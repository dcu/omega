module Omega
  class Application
    attr_reader :middleware
    attr_reader :request, :params, :env, :response
    attr_accessor :public_dir

    def initialize
      super
    end

    def self.middleware
      @middleware ||= begin
        builder = Rack::Builder.new
        builder.use Rack::CommonLogger
        builder.use Omega::Static, :public_folder => "#{Omega.root}/public"
        builder.use Omega::Assets
        builder.use Rack::Parser
        builder.run self.new
        builder
      end
    end

    def self.instance
      @application ||= Omega::Application.new
    end

    def self.call(env)
      self.middleware.dup.call(env)
    end

    def call(env)
      @request = Rack::Request.new(env)
      @params = request.params
      @response = Rack::Response.new

      if Omega.env == :development
        compile_templates
      end

      catch(:halt) {
        process_request!
      }.finish
    end

    def process_request!
      match, route_info = Omega::Router.find(request.request_method, request.path_info)
      halt 404 if match.nil?

      if (captures = match.captures) && !captures.empty?
        url_params = Hash[*route_info[:keys].zip(captures).flatten]
        @params = url_params.merge(params)
      end

      if !request.xhr? && request.get? && params["format"] != "json"
        response.write eval_layout(route_info)
      else
        response.write eval_action(route_info)
      end

      throw :halt, response
    end

    def halt(status, body = nil, headers = nil)
      @response.status = status
      @response.write(body) if body
      @response.header.merge!(headers) if headers

      throw :halt, @response
    end

    def eval_action(route_info)
      controller = route_info[:controller_class].new
      controller._application = self
      controller.request = @request
      controller.response = @response
      controller.params = @params.with_indifferent_access
      controller.env = @env

      controller.instance_eval(&route_info[:block])
    end
    
    def eval_layout(route_info)
      layout = route_info[:controller_class].layout || "application"
      File.read(Omega.root("public/_templates/layouts/#{layout}.html"))
    end

    def compile_templates
      templates.each do |template_path, ctime|
        next if File.mtime(template_path) < ctime

        template = Tilt::HamlTemplate.new(template_path)

        html_file = template_path.sub(%r{^#{Regexp.escape(Omega.root)}/(app|assets)/(\w+)(/views){0,1}/(.+)\.haml}, 'public/_templates/\2/\4')
        html_file << ".html" if html_file !~ /\.html$/

        FileUtils.mkpath(File.dirname(html_file))

        puts ">> Compiling #{template_path} => #{html_file}"
        File.open(html_file, "w") do |f|
          f.write template.render
        end

        templates[template_path] = Time.now
      end
    end

    def templates
      @templates ||= begin
        temp = {}
        Find.find("#{Omega.root}/app", "#{Omega.root}/assets").each do |path|
          temp[path] = File.mtime(path) - 1 if path.end_with?(".haml")
        end

        temp
      end
    end
  end
end

