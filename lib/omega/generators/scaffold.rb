module Omega
  module Generators
    class Scaffold < Thor::Group
      include Thor::Actions

      source_root File.expand_path("../templates", __FILE__)
      argument :name, :type => :string, :desc => "Name of the controller"

      def create_directory
        empty_directory "app/#{underscore_name}"
        empty_directory "app/#{underscore_name}/views"
      end

      def create_controllers
        template "scaffold/controller.rb.erb", 
                 "app/#{underscore_name}/#{underscore_name}_controller.rb"
        template "scaffold/index_controller.coffee.erb", 
                 "app/#{underscore_name}/views/index_controller.coffee"
        template "scaffold/show_controller.coffee.erb", 
                 "app/#{underscore_name}/views/show_controller.coffee"
      end

      def create_views
        # index
        template "scaffold/index_style.sass.erb", 
                 "app/#{underscore_name}/views/index_style.sass"
        template "scaffold/index_view.haml.erb", 
                 "app/#{underscore_name}/views/index_view.haml"

        # show
        template "scaffold/show_style.sass.erb", 
                 "app/#{underscore_name}/views/show_style.sass"
        template "scaffold/show_view.haml.erb", 
                 "app/#{underscore_name}/views/show_view.haml"
      end

      def create_models
        template "scaffold/model.rb.erb", 
                 "app/models/#{resource_name}.rb"
        template "scaffold/model.coffee.erb", 
                 "app/models/#{resource_name}.coffee"
      end

      def insert_angular_deps
        inject_into_file "app/app.coffee", %@dependencies.push("#{resource_name}_model")\n@, :before => "window.App ="
      end

      def insert_routes
        routes = %@
  $routeProvider.when "#{route}",
    controller: #{class_name}IndexController
    templateUrl: "/_templates#{route}/index.html"

  $routeProvider.when "#{route}/:id",
    controller: #{class_name}ShowController
    templateUrl: "/_templates#{route}/show.html"
    
@

        inject_into_file "app/app.coffee", routes, :before => "$routeProvider.when"
      end

      private
        def underscore_name
          name.underscore
        end

        def model_name
          name.classify
        end

        def collection_name
          underscore_name
        end

        def resource_name
          model_name.underscore
        end
        
        def class_name
          name.titleize.gsub(/\s+/, "")
        end

        def route
          "/"+name.underscore
        end
    end
  end
end

