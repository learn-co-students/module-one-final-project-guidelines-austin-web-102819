require 'bundler'
Bundler.require
require 'rest-client'
require 'json'
require 'pry'

ActiveRecord::Base.logger = nil
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.sqlite3')
# ActiveSupport::Deprecation.behavior=silence
require_all 'app'
