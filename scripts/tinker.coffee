# Description:
#   Tinker's kind of an asshole
#
# Dependencies:
#   none
#
# Notes:
#
# Author:
#   Tori Holmes-Kirk <tori.kirk@gmail.com> (https://github.com/supertorio)



_starWarsDay2015 = new Date('December 18, 2015 00:00:00');

module.exports = (robot) ->

  robot.hear /star wars/i, (robot) ->
    today = Date.now()
    if (today > _starWarsDay2015)
      robot.send "YAY Star Wars Day is Here!"
    else
      numDays = Math.round((_starWarsDay2015-today)/(1000*60*60*24));
      robot.send ":bb8: Did you know there is only #{numDays} days until Star Wars The Force Awakens?!? :c3p0::stormtrooper:"

  robot.respond /I love you/i, (res) ->
    res.send "I know..."

  robot.respond /Who shot first\?/i, (res) ->
    res.send "HAN. SHOT. FIRST."
