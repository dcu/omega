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
        mw = Rack::Builder.new
        mw.use Rack::CommonLogger
        mw.use Omega::Static, :public_folder => "#{Omega.root}/public"
        mw.use Omega::Assets
        mw.run self.new
        mw
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
      @env = env

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
      response.write eval_action(route_info)

      throw :halt, response
    end

    def halt(status, body = nil, headers = nil)
      @response.status = status
      @response.body = body if body
      @response.header.merge!(headers) if headers

      throw :halt, @response
    end

    def eval_action(route_info)
      controller = route_info[:controller_class].new
      controller.request = @request
      controller.response = @response
      controller.params = @params.with_indifferent_access
      controller.env = @env

      controller.instance_eval(&route_info[:block])
    end

    def compile_templates
      templates.each do |template_path|
        template = Tilt::HamlTemplate.new(template_path)

        html_file = template_path.sub(%r{^#{Regexp.escape(Omega.root)}/app/(\w+)/views/(.+)\.haml}, 'public/_templates/\1/\2')
        html_file << ".html" if html_file !~ /\.html$/

        FileUtils.mkpath(File.dirname(html_file))

        File.open(html_file, "w") do |f|
          f.write template.render
        end
      end
    end

    def templates
      @templates ||= Find.find("#{Omega.root}/app").select {|path| path =~ /\.haml$/ }
    end
  end
end

