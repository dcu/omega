require 'json'
require 'set'
require 'pry'
require 'find'
require 'haml'
require 'sass'

require 'mongoid'
require 'sprockets'
require 'active_support'
require 'active_support/core_ext/hash'
require 'rack/builder'

require 'omega/router'
require 'omega/assets'
require 'omega/static'
require 'omega/application'
require 'omega/controller'

module Omega
  def self.root(path = nil)
    path ? "#{OMEGA_ROOT}/#{path}" : OMEGA_ROOT
  end

  def self.env
    OMEGA_ENV
  end

  def self.require_files!
    Dir["#{Omega.root}/app/**/**/*.rb"].each do |file_path|
      require file_path
    end
  end

  def self.load!
    Omega.require_files!
    Omega::Assets.setup!
    Omega::Router.sort_routes!
  end
end

