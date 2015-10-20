# Description:
#   Weather via Wunderground
#
# Dependencies:
#   rsvp
#
# Configuration:
#   env variable WUNDERGROUND_KEY must contain valid API Key
#
# Commands:
#   weather <location> - Fetches forecast for a location
#
# Notes:
#
# Author:
#   Tori Holmes-Kirk <tori.kirk@gmail.com> (https://github.com/supertorio)

RSVP = require('rsvp');

_wgApiKey = process.env.WUNDERGROUND_KEY
_wgURL = 'http://api.wunderground.com/api/'

iconMap =
  chanceflurries : ":grey_question::snowflake:"
  chancerain : ":grey_question::droplet:"
  chancesleet : ":grey_question::snowflake:"
  chancesnow : ":grey_question::snowflake:"
  chancetstorms : ":grey_question::zap::sweat_drops:"
  clear : ":sunny:"
  cloudy : ":cloud:"
  flurries : ""
  fog : ":dash:"
  hazy : ":sunny:"
  mostlycloudy : ":partly_sunny:"
  mostlysunny : ":partly_sunny:"
  partlycloudy : ":partly_sunny:"
  partlysunny : ":partly_sunny:"
  sleet : ":snowflake:"
  rain : ":sweat_drops:"
  snow : ":snowflake:"
  sunny : ":sunny:"
  tstorms : ":zap::sweat_drops:"
  nt_chanceflurries : ":crescent_moon::grey_question::snowflake:"
  nt_chancerain : ":crescent_moon::grey_question::droplet:"
  nt_chancesleet : ":crescent_moon::grey_question::snowflake:"
  nt_chancesnow : ":crescent_moon::grey_question::snowflake:"
  nt_chancetstorms : ":crescent_moon::grey_question::zap::sweat_drops:"
  nt_clear : ":crescent_moon:"
  nt_cloudy : ":crescent_moon::cloud:"
  nt_flurries : ":crescent_moon::snowflake:"
  nt_fog : ":crescent_moon::dash:"
  nt_hazy : ":crescent_moon:"
  nt_mostlycloudy : ":crescent_moon::cloud:"
  nt_mostlysunny : ":crescent_moon::cloud:"
  nt_partlycloudy : ":crescent_moon::cloud:"
  nt_partlysunny : ":crescent_moon::cloud:"
  nt_sleet : ":crescent_moon::snowflake:"
  nt_rain : ":crescent_moon::sweat_drops:"
  nt_snow : ":crescent_moon::snowflake:"
  nt_sunny : ":crescent_moon:"
  nt_tstorms : ":crescent_moon::zap::sweat_drops:"


getRequest = (robot, url, callback) ->
  robot.http("#{url}")
  .get() (err, res, body) ->
    callback(err, res, body)


printForecast = (robot, daysFC) ->
  output = ""
  for fc in daysFC
    output += "*#{fc.title}*: #{iconMap[fc.icon]} #{fc.fcttext}\n"
  robot.send output


getGeoLookupForLocation = (robot, locationStr) -> new RSVP.Promise (resolve, reject) ->
  getRequest robot, "#{_wgURL}#{_wgApiKey}/geolookup/q/#{locationStr}.json", (err, res, body) ->
    resolve JSON.parse body


getForecastForLocation = (robot, link) -> new RSVP.Promise (resolve, reject) ->
  getRequest robot, "#{_wgURL}#{_wgApiKey}/forecast/#{link}.json", (err, res, body) ->
    resolve JSON.parse body


getWeatherForLocation = (robot, location) ->
  robot.send "Checking..."
  getGeoLookupForLocation(robot, location)
    .then (res) ->
      getForecastForLocation(robot, res.location.l)
        .then (res) ->
          days = res.forecast.txt_forecast.forecastday
          printForecast robot, days






module.exports = (robot) ->

  robot.respond /weather (.*)/i, (robot) ->
    location = robot.match[1]
    getWeatherForLocation robot, location
