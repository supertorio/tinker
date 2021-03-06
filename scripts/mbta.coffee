# Description:
#   MBTA Information via the developer API
#
# Dependencies:
#   none
#
# Configuration:
#   env variable MBTA_API_KEY must contain valid MBTA Developer API Key
#
# Commands:
#   hubot mbta status - displays status messages from the MBTA
#
# Notes:
#
# Author:
#   Tori Holmes-Kirk <tori.kirk@gmail.com> (https://github.com/supertorio)

mbtaApiKey = process.env.MBTA_API_KEY
mbtaURL = 'http://realtime.mbta.com/developer/api/v2/'
_i = 0
_len = 0


# Temporarily Hardcode these
# TODO: Parse from api and persist to hubot-redis-brain
trainLines =
  blue:
    outbound: '946_'
    inbound: '948_'
  orange:
    outbound: '903_'
    inbound: '913_'
  red:
    outbound: '931_'
    inbound: '933_'


getRequest = (msg, url, callback) ->
  msg.http("#{url}")
    .get() (err, res, body) ->
      callback(err, res, body)


getMBTAStatus = (msg) ->
  msg.send "Checking..."
  getRequest msg, "#{mbtaURL}alertheaders?api_key=#{mbtaApiKey}&format=json", (err, res, body) ->
    response = JSON.parse body
    alertHeaders = response.alert_headers
    displayAlert msg, alert for alert in alertHeaders

displayAlert = (msg, alert) ->
  msg.send "> #{alert.header_text}"


getTimesForStop = (msg, line, station) ->
  msg.send "Checking..."
  msg.send "> #{line}, #{station}"


module.exports = (robot) ->

  robot.respond /mbta status/i, (msg) ->
    getMBTAStatus msg

#  robot.respond /what is the next (orange|red|green|blue|silver)(?: line)? train at (.*)(.?)/i, (msg) ->
#    line  = msg.match[1]
#    station = msg.match[2]
#    getTimesForStop msg, line, station
