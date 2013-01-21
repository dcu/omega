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

    def self.add_route(controller_class, http_method, name, pattern, block)
      route_info = {
        :controller_class => controller_class,
        :name => name,
        :pattern => pattern,
        :block => block,
        :keys => []
      }
      matcher = pattern.gsub(/(:\w+)/) do |match|
        route_info[:keys] << $1[1..-1]
        "([^/?#]+)"
      end
      route_info[:matcher] = %r{^#{matcher}$}

      routes[http_method] << route_info

      self.sort_routes! # FIXME: move this from here!
    end
  end
end

