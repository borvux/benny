require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")
  erb(:homepage)
end
