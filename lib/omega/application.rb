module Omega
  class Application
    attr_reader :request, :params, :env, :response

    def initialize
      @builder = Rack::Builder.new(self)
    end

    def self.instance
      @application ||= Omega::Application.new
    end

    def self.call(env)
      @builder.dup.call(env)
    end

    def call(env)
      @request = Rack::Request.new(env)
      @params = request.params
      @response = Rack::Response.new
      @env = env

      if request.path_info.start_with?("/assets/")
        env['PATH_INFO'].gsub!("/assets", "")
        return Omega::Assets.environment.call(env)
      end

      catch(:halt) {
        process_request(request)
      }.finish
    end

    def process_request(request)
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
  end
end

