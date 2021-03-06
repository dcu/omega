# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "omega-framework"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David A. Cuadrado"]
  s.date = "2013-11-24"
  s.description = "Ruby web framework to create angular-based applications."
  s.email = "krawek@gmail.com"
  s.executables = ["omega", "omega-cli"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/omega",
    "bin/omega-cli",
    "lib/omega.rb",
    "lib/omega/application.rb",
    "lib/omega/assets.rb",
    "lib/omega/controller.rb",
    "lib/omega/generators.rb",
    "lib/omega/generators/project.rb",
    "lib/omega/generators/scaffold.rb",
    "lib/omega/generators/templates/project/app.coffee.erb",
    "lib/omega/generators/templates/project/layout.haml.erb",
    "lib/omega/generators/templates/project/mongoid.yml.erb",
    "lib/omega/generators/templates/scaffold/controller.rb.erb",
    "lib/omega/generators/templates/scaffold/edit_controller.coffee.erb",
    "lib/omega/generators/templates/scaffold/edit_style.sass.erb",
    "lib/omega/generators/templates/scaffold/edit_view.haml.erb",
    "lib/omega/generators/templates/scaffold/index_controller.coffee.erb",
    "lib/omega/generators/templates/scaffold/index_style.sass.erb",
    "lib/omega/generators/templates/scaffold/index_view.haml.erb",
    "lib/omega/generators/templates/scaffold/model.coffee.erb",
    "lib/omega/generators/templates/scaffold/model.rb.erb",
    "lib/omega/generators/templates/scaffold/new_controller.coffee.erb",
    "lib/omega/generators/templates/scaffold/new_style.sass.erb",
    "lib/omega/generators/templates/scaffold/new_view.haml.erb",
    "lib/omega/generators/templates/scaffold/show_controller.coffee.erb",
    "lib/omega/generators/templates/scaffold/show_style.sass.erb",
    "lib/omega/generators/templates/scaffold/show_view.haml.erb",
    "lib/omega/generators/templates/skel/Gemfile",
    "lib/omega/generators/templates/skel/Procfile",
    "lib/omega/generators/templates/skel/README.md",
    "lib/omega/generators/templates/skel/Rakefile",
    "lib/omega/generators/templates/skel/app/helpers/common_helper.rb",
    "lib/omega/generators/templates/skel/app/models/.empty_directory",
    "lib/omega/generators/templates/skel/app/welcome/views/index_controller.coffee",
    "lib/omega/generators/templates/skel/app/welcome/views/index_style.sass",
    "lib/omega/generators/templates/skel/app/welcome/views/index_view.haml",
    "lib/omega/generators/templates/skel/app/welcome/welcome_controller.rb",
    "lib/omega/generators/templates/skel/assets/fonts/.empty_directory",
    "lib/omega/generators/templates/skel/assets/javascripts/.empty_directory",
    "lib/omega/generators/templates/skel/assets/javascripts/angular/.empty_directory",
    "lib/omega/generators/templates/skel/assets/javascripts/application.coffee",
    "lib/omega/generators/templates/skel/assets/layouts/.empty_directory",
    "lib/omega/generators/templates/skel/assets/stylesheets/.empty_directory",
    "lib/omega/generators/templates/skel/assets/stylesheets/application.sass",
    "lib/omega/generators/templates/skel/config.ru",
    "lib/omega/generators/templates/skel/config/boot.rb",
    "lib/omega/generators/templates/skel/config/env.rb.sample",
    "lib/omega/generators/templates/skel/config/initializers/.empty_directory",
    "lib/omega/generators/templates/skel/log/.empty_directory",
    "lib/omega/router.rb",
    "lib/omega/static.rb",
    "lib/omega/tasks.rb",
    "lib/omega/tasks/mongoid.rake",
    "omega-framework.gemspec",
    "skel/Gemfile",
    "skel/Procfile",
    "skel/README.md",
    "skel/Rakefile",
    "skel/app/models/post.coffee",
    "skel/app/models/post.rb",
    "skel/app/posts/posts_controller.rb",
    "skel/app/posts/views/index_controller.coffee",
    "skel/app/posts/views/index_style.sass",
    "skel/app/posts/views/index_view.haml",
    "skel/app/posts/views/posts_router.coffee",
    "skel/assets/fonts/.gitkeep",
    "skel/assets/javascripts/.gitkeep",
    "skel/assets/stylesheets/.gitkeep",
    "skel/config.ru",
    "skel/config/boot.rb",
    "skel/config/env.rb",
    "skel/config/initializers/.gitkeep",
    "skel/config/mongoid.yml",
    "spec/omega_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/dcu/omega-gem"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Ruby web framework to create angular-based applications."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thor>, [">= 0"])
      s.add_runtime_dependency(%q<sprockets>, [">= 0"])
      s.add_runtime_dependency(%q<coffee-script>, [">= 0"])
      s.add_runtime_dependency(%q<mongoid>, [">= 0"])
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_runtime_dependency(%q<sass>, [">= 0"])
      s.add_runtime_dependency(%q<pry>, [">= 0"])
      s.add_runtime_dependency(%q<rack-parser>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<thor>, [">= 0"])
      s.add_dependency(%q<sprockets>, [">= 0"])
      s.add_dependency(%q<coffee-script>, [">= 0"])
      s.add_dependency(%q<mongoid>, [">= 0"])
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<sass>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<rack-parser>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<thor>, [">= 0"])
    s.add_dependency(%q<sprockets>, [">= 0"])
    s.add_dependency(%q<coffee-script>, [">= 0"])
    s.add_dependency(%q<mongoid>, [">= 0"])
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<sass>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<rack-parser>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

