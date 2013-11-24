require 'json'
require 'set'
require 'find'
require 'active_support'
require 'active_support/core_ext/hash'

autoload :Mongoid, 'mongoid'
autoload :Sprockets, 'sprockets'
autoload :Logger, 'logger'
autoload :Haml, 'haml'
autoload :Sass, 'sass'

module Rack
  autoload :Builder, 'rack/builder'
  autoload :Parser, 'rack/parser'
end

module Omega
  autoload :Router, 'omega/router'
  autoload :Assets, 'omega/assets'
  autoload :Static, 'omega/static'
  autoload :Application, 'omega/application'
  autoload :Controller, 'omega/controller'

  def self.root(path = nil)
    path ? "#{OMEGA_ROOT}/#{path}" : OMEGA_ROOT
  end

  def self.env
    OMEGA_ENV
  end

  def self.require_files!
    Dir["#{Omega.root}/app/{models,helpers}/**/*.rb"].each do |file_path|
      require file_path
    end

    Dir["#{Omega.root}/app/**/**/*.rb"].each do |file_path|
      require file_path
    end
  end

  def self.after_loading(&block)
    self.after_loading_callbacks.push(block)
  end

  def self.after_loading_callbacks
    @after_loading_callbacks ||= []
  end

  def self.load!
    Thread.start do
      Omega.require_files!
      Omega::Assets.setup!

      Omega::Router.sort_routes!

      Omega.after_loading_callbacks.each do |callback|
        callback.call
      end
    end
  end

  def self.logger
    @logger ||= Logger.new(env == :development ? STDERR : Omega.root("log/#{env}"))
  end
end

