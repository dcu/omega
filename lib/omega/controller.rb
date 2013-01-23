module Omega
  class Controller
    attr_accessor :request, :response, :params, :env

    class << self
      %w[GET HEAD POST PUT PATCH DELETE].each do |http_method|
        define_method(http_method.downcase) do |named_routes, &block|
          named_routes.each do |name, route|
            Omega::Router.add_route(self, http_method, name, route, block)
          end
        end
      end
    end

    def halt(status, body = nil, headers = nil)
      Omega::Application.instance.halt(status, body, headers)
    end

    def ok
      halt 200
    end
  end
end

