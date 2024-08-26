require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  pirate_weather_api_key = ENV["PIRATE_WEATHER_KEY"]
  latitude = 41.8183339
  longitude =  -88.1515551

  # Pirate Weather API request
  pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_api_key}/#{latitude},#{longitude}"
  raw_pirate_weather_data = HTTP.get(pirate_weather_url)
  parsed_pirate_weather_data = JSON.parse(raw_pirate_weather_data)

  # to check if the currently exist
  if parsed_pirate_weather_data.key?("currently")
    currently_hash = parsed_pirate_weather_data.fetch("currently")
    @temperature = currently_hash.fetch("temperature")
    @current_summary = currently_hash.fetch("summary").downcase
  else
    @output = "Seems like either the Google Map API or Pirate Weather API is down, sorry for inconvience, please try refreshing the page"
  end
  
  # check to see if it is raining
  if @current_summary == "rain"
    @output = "It is #{@temperature}* and it's #{@current_summary}, seems like I need an umbrella."
  else
    @output = "It is #{@temperature}* and it's #{@current_summary}, seems like I won't need an umbrella."
  end
  erb(:homepage)
end

get("/project1") do
  erb(:project1)
end

get("/project2") do
  erb(:project2)
end

get("/project3") do
  erb(:project3)
end
