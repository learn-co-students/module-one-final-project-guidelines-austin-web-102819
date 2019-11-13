require 'bundler'
Bundler.require
require 'rest-client'
require 'json'
require 'pry'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.sqlite3')
require_all 'app'
