 # This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require 'active_record'

run Rails.application
