# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Parse RESTfull API configuration
require 'parse-ruby-client'

Parse.init :application_id => "L6SLBxrQtNVjvdO8TCaYH7rpMHStR832rJoTloW0",
           :api_key        => "zqZskYHskGj6R2eMxBBS7Q4b6eUJ09VJHYVgKrXR"
