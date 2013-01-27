module Omega
  module Generators
    class Project < Thor::Group
      include Thor::Actions

      source_root File.expand_path("../templates", __FILE__)
      argument :name, :type => :string, :desc => "Name of the project"

      def create_root
        directory "skel", name
      end

      def generate_mongoid_yml
        template "project/mongoid.yml.erb", "#{name}/config/mongoid.yml"
      end

      def create_angular_app
        template "project/app.coffee.erb", "#{name}/app/app.coffee"
      end

      def generate_layout
        template "project/layout.haml.erb", "#{name}/assets/layouts/application.haml"
      end

      def download_jquery
        get "https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js", "#{name}/assets/javascripts/jquery.js"
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

      def download_bootstrap
        # stylesheets
        get "http://twitter.github.com/bootstrap/assets/css/bootstrap.css", "#{name}/assets/stylesheets/bootstrap.css"
        empty_directory "#{name}/assets/stylesheets/bootstrap"
        get "http://twitter.github.com/bootstrap/assets/css/bootstrap-responsive.css", "#{name}/assets/stylesheets/bootstrap/bootstrap-responsive.css"

        # javascripts
        get "http://twitter.github.com/bootstrap/assets/js/bootstrap.js", "#{name}/assets/javascripts/bootstrap.js"
        empty_directory "#{name}/assets/javascripts/bootstrap"

        %w[bootstrap-transition bootstrap-alert bootstrap-modal bootstrap-dropdown bootstrap-scrollspy 
           bootstrap-tab bootstrap-tooltip bootstrap-popover bootstrap-button bootstrap-collapse bootstrap-carousel 
           bootstrap-typeahead bootstrap-affix].each do |plugin|
          get "http://twitter.github.com/bootstrap/assets/js/#{plugin}.js", "#{name}/assets/javascripts/bootstrap/#{plugin}.js"
        end
      end

      private
        def dbname
          name.underscore
        end
    end
  end
end

