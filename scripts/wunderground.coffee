RSVP = require('rsvp');

_wgApiKey = process.env.WUNDERGROUND_KEY
_wgURL = 'http://api.wunderground.com/api/'


getRequest = (robot, url, callback) ->
  robot.http("#{url}")
  .get() (err, res, body) ->
    callback(err, res, body)


printForecast = (robot, daysFC) ->
  output = ""
  for fc in daysFC
    output += "*#{fc.title}*: ![#{fc.icon}](#{fc.icon_url}) #{fc.fcttext}\n"
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
