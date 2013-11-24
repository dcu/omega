# Defines our constants
OMEGA_ENV  = (ENV['OMEGA_ENV'] ||= ENV['RACK_ENV'] ||= 'development').to_sym  unless defined?(OMEGA_ENV)
OMEGA_ROOT = File.expand_path('../..', __FILE__) unless defined?(OMEGA_ROOT)

require 'rubygems' unless defined?(Gem)
require 'bundler'

Bundler.setup(:default, OMEGA_ENV)

# Load local config
require Omega.root("/config/env.rb") if File.exist?(Omega.root("/config/env.rb"))

# Load mongoid configuration
Mongoid.load!("#{Omega.root}/config/mongoid.yml")

Omega.load!

