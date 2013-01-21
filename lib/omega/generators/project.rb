module Omega
  module Generators
    class Project < Thor::Group
      include Thor::Actions

      source_root File.expand_path("../templates", __FILE__)
      argument :name, :type => :string, :desc => "Name of the project"

      def create_root
        directory "skel", name
      end

      def create_angular_app
        template "project/app.coffee.erb", "#{name}/app/app.coffee"
      end

      def generate_layout
        template "project/layout.haml.erb", "#{name}/assets/layouts/application.haml"
      end

      def download_angular
        get "http://code.angularjs.org/1.0.3/angular.js", "#{name}/assets/javascripts/angular.js"

        [
          "http://code.angularjs.org/1.0.3/angular-resource.js",
          "http://code.angularjs.org/1.0.3/angular-cookies.js",
          "http://code.angularjs.org/1.0.3/angular-sanitize.js"
        ].each do |url|
          get url, "#{name}/assets/javascripts/angular/#{url.split("/").last}"
        end
      end

      private
    end
  end
end

