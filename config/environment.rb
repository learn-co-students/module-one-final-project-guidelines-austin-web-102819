require 'bundler'
# require 'rake'
require 'active_record'
# require 'rest-client'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.sqlite')
# require_all 'lib' -----> ORIGINAL
require_all 'app'  








