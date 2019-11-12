require 'bundler'
Bundler.require

require "sinatra/activerecord"
require 'rake'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: '../db/epicure.sqlite')
# ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/epicure.sqlite')
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
# require_all 'app'
