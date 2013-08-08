module Omega
  class Router
    def self.routes
      @routes ||= Hash.new {|h,k| h[k]=[]}
    end

    def self.find(http_method, path_info)
      self.routes[http_method].each do |route_info|
        if match = path_info.match(route_info[:matcher])
          return match, route_info
        end
      end

      return nil
    end

    def self.sort_routes!
      self.routes.each do |method, routes|
        routes.sort_by! do |route_info|
          -route_info[:pattern].split("/").delete_if {|e| e.match(/:(\w+)/) }.length
        end
      end
    end

    def self.add_route(controller_class, route_info)
      http_method = route_info[:method]
      route_info.merge!({
        :controller_class => controller_class,
        :keys => []
      })

      matcher = route_info[:pattern].gsub(/(:\w+)/) do |match|
        route_info[:keys] << $1[1..-1]
        "([^/?#]+)"
      end
      route_info[:matcher] = %r{^#{matcher}$}

      Omega.logger.info "Added route #{http_method.upcase} #{controller_class}##{route_info[:name]} #{route_info[:pattern]}"

      routes[http_method] << route_info
    end
  end
end

