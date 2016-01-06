ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

# =========== local development ===========================
#require 'bundler/setup' # Set up gems listed in the Gemfile.

# =========== server development ===========================
require 'rails/commands/server'
module Rails
  class Server
    def default_options
      super.merge(Host:  '192.168.58.74', Port: 80)
    end
  end
end