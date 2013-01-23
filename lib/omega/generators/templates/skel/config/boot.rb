# Defines our constants
OMEGA_ENV  = ENV['OMEGA_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(OMEGA_ENV)
OMEGA_ROOT = File.expand_path('../..', __FILE__) unless defined?(OMEGA_ROOT)

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, OMEGA_ENV)

Omega.load!

