require "sinatra/base"
require "sinatra/json"
require "pry"

DB = {}

class Coloson < Sinatra::Base
  get "/numbers/even" do
    json DB
end

#evens section

post "/numbers/evens" do
   body = request.body.read

   begin
     new_num = JSON.parse body
   rescue
     status 400
     halt "Can't parse json: '#{body}'"
   end

   if new_num["num"]
     DB.push num
     body "ok"
   else
     status 422
     body "Not a number"
   end
 end

#   #  Odds section
#   post "/numbers/odds" do
#      body = request.body.read
#
#      begin
#        new_num = JSON.parse body
#      rescue
#        status 400
#        halt "Can't parse json: '#{body}'"
#      end
#
#      if new_num["num"]
#        DB.push num
#        body "ok"
#      else
#        status 422
#        body "Not a number"
#      end
#    end
#
#   delete "/numbers/odds" do
#     title = params[:title]
#     existing_item = DB.find { |n| i["num"] == num }
#     if existing_item
#       DB.delete existing_item
#       status 200
#     else
#       status 404
#     end
#   end
# end
# # Prime section
#
#   post "/numbers/primes" do
#      body = request.body.read
#
#      begin
#        new_num = JSON.parse body
#      rescue
#        status 400
#        halt "Can't parse json: '#{body}'"
#      end
#
#      if new_num["num"]
#        DB.push num
#        body "ok"
#      else
#        status 422
#        body "Not a number"
#      end
#    end


Coloson.run! if $PROGRAM_NAME == __FILE__
end
