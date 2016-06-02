require "sinatra/base"
require "sinatra/json"
require "pry"
require "json"
require "./tests.rb"
require "prime.rb"

class Coloson < Sinatra::Base

set :logging, true
set :show_exceptions, false
  # set :show_exceptions, false
  # error do |e|
  #   raise e
  # end

  DB["evens"] = []
  DB["primes"] = []
  DB["odds"] = []
  DB["account"] = []

  def self.reset_database
    DB.clear
  end

#evens section
  get "/numbers/evens" do
    DB["evens"] ||= []
    json DB["evens"]
  end

  get "/numbers/evens/sum" do
    sum = DB["evens"].reduce(:+)
    json {"status" => "ok", "sum" => sum}
  end

  post "/numbers/evens" do
    number = params[:number]
    if number.to_i%2 == 0 && number == number.to_i.to_s
      DB["evens"].push number.to_i
      json
    else
      status 422
      json {"status" => "error", "error" => "Invalid number: #{number}"}
    end
  end

  delete "/numbers/evens" do
    number = params[:number]
    existing_number = DB["evens"].find { |i| i == number.to_i }
    DB["evens"].delete existing_number
    json DB["evens"]
  end


#prime section
  get "/numbers/primes" do
    DB["primes"] ||= []
    json DB["primes"]
  end

  get "/numbers/primes/sum" do
    sum = DB["primes"].reduce(:+)
    json {"status" => "ok", "sum" => sum}
  end

  post "/numbers/primes" do
    number = params[:number]
    if Prime.prime?(number.to_i) && number == number.to_i.to_s
      DB["primes"].push number.to_i
      json
    else
      status 422
      json {"status" => "error", "error" => "Invalid number: #{number}"}
    end
  end

  delete "/numbers/primes" do
    number = params[:number]
    existing_number = DB["primes"].find { |i| i == number.to_i }
    DB["primes"].delete existing_number
    json DB["primes"]
  end

#mine or account section section

  get "/numbers/mine/product" do
    product = DB["account"].inject(1) { |product, number| product * number }

    if product < 25
      json { "status" => "ok", "product" => product }
    else
      json { "status" => "error", "error" => "Only paid users can multiply numbers that large"}
      status 422
    end
  end

  post "/numbers/mine" do
    number = params[:number]
    if number == number.to_i.to_s
      DB["account"].push number.to_i
      json
    else
      status 422
      json {"status" => "error", "error" => "Invalid number: #{number}"}
    end
  end

  delete "/numbers/mine" do
    number = params[:number]
    existing_number = DB["account"].find { |i| i == number.to_i }
    DB["account"].delete existing_number
    json DB["account"]
  end

#odds section

  get "/numbers/odds" do
    DB["odds"] ||= []
    json DB["odds"]
  end

  get "/numbers/odds/sum" do
    sum = DB["odds"].reduce(:+)
    json {"status" => "ok", "sum" => sum}
  end

  post "/numbers/odds" do
    number = params[:number]
    if number.to_i%2 == 1 && number == number.to_i.to_s
      DB["odds"].push number.to_i
      json
    else
      status 422
      json {"status" => "error", "error" => "Invalid number: #{number}"}
    end
  end

  delete "/numbers/odds" do
    number = params[:number]
    existing_number = DB["odds"].find { |i| i == number.to_i }
    DB["odds"].delete existing_number
    json DB["odds"]
  end
end

Coloson.run! if $PROGRAM_NAME == __FILE__
