RSVP = require('rsvp');

_wgApiKey = process.env.WUNDERGROUND_KEY
_wgURL = 'http://api.wunderground.com/api/'


getRequest = (robot, url, callback) ->
  robot.http("#{url}")
  .get() (err, res, body) ->
    callback(err, res, body)


printForecast = (robot, fc) ->
  robot.send "#{fc.title}: #{fc.fcttext}"


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
          printForecast robot, fc for fc in days






module.exports = (robot) ->

  robot.respond /weather (.*)/i, (robot) ->
    location = robot.match[1]
    getWeatherForLocation robot, location