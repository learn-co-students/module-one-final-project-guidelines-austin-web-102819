require 'bundler'
Bundler.require

require "sinatra/activerecord"
require 'rake'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/epicure.sqlite')
require_all 'app'
