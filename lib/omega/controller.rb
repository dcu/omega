module Omega
  class Controller
    attr_accessor :request, :response, :params, :env, :_application

    class << self
      %w[GET HEAD POST PUT PATCH DELETE].each do |http_method|
        define_method(http_method.downcase) do |*args, &block|
          options = args.extract_options!

          raise ArgumentError, %@Invalid route definition. Try instead: #{http_method.downcase} :name, "/the/path", :before => :check_that do ... end@ if args.size != 2
          options.assert_valid_keys(:before)

          route_name = args[0]
          route_path = args[1]
          if (bef = options[:before]) && !bef.kind_of?(Array)
            options[:before] = [bef] #ensures before is an array
          end

          Omega::Router.add_route(self, options.merge({
            :method => http_method,
            :name => route_name, 
            :pattern => route_path,
            :block => block
          }))
        end
      end

      def helper(*helpers)
        helpers.each do |helper|
          include "#{helper}_helper".classify.constantize
        end
      end

      def layout(layout = nil)
        @layout ||= layout
      end
    end

    def session
      request.session
    end

    def halt(status, body = nil, headers = nil)
      @_application.halt(status, body, headers)
    end

    def ok
      halt 200
    end

    def respond_with(object)
      halt 200, object.to_json
    end
  end
end

