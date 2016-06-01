require "sinatra/base"
require "sinatra/json"
require "pry"

DB = {}

class Coloson < Sinatra::Base
  # Your code goes here ...
end

Coloson.run! if $PROGRAM_NAME == __FILE__
