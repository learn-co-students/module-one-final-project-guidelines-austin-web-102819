require 'bundler'
Bundler.require

<<<<<<< HEAD
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: '../db/epicure.sqlite')
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
=======

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: '../db/epicure.sqlite')
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}

>>>>>>> 638f37cdea8583048e3ec425e8db89f78b4f522d
