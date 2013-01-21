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

      private
    end
  end
end

