require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  gmaps_api_key = ENV.fetch("GMAPS_KEY")
  pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")
  
  # google maps api request
  google_maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=wheaton&key=#{gmaps_api_key}"

  # getting to the latitude and longtitude
  raw_google_maps_data = HTTP.get(google_maps_url)
  parsed_google_maps_data = JSON.parse(raw_google_maps_data)
  results_array = parsed_google_maps_data.fetch("results")
  first_result_hash = results_array.at(0)
  geometry_hash = first_result_hash.fetch("geometry")
  location_hash = geometry_hash.fetch("location")

  # getting the location of wheaton
  latitude = location_hash.fetch("lat")
  longitude = location_hash.fetch("lng")

  # pirate weather api request
  pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_api_key}/#{latitude},#{longitude}"

  # getting the weather at wehaton
  raw_pirate_weather_data = HTTP.get(pirate_weather_url)
  parsed_pirate_weather_data = JSON.parse(raw_pirate_weather_data)
  currently_hash = parsed_pirate_weather_data.fetch("currently")
  @temperature = currently_hash.fetch("temperature")

  erb(:homepage)
end
