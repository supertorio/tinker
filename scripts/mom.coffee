###*
# hubot script for telling Mom Jokes
###

jokes = [
    "{victim} mom is so fat, I took a picture of her last Christmas and it's still printing.",
    "{victim} mom is so fat that, when she fell in love, she broke it.",
    "{victim} mom is like the sun: big, round, and hard to look at.",
    "{victim} mom is so stupid that, when she heard it was chilly outside, she went to grab a bowl.",
    "{victim} mom is so stupid: she stared at a carton of juice because it said 'Concentrate.'",
    "{victim} mom is so fat she’s on both sides of the family.",
    "{victim} mom is so old that she knew Burger King when he was a prince.",
    "{victim} mom is so fat she had to get baptized at Sea World.",
    "{victim} mom is so ugly that, when she was born, the doctor threw her to the wolves- and the wolves threw her back.",
    "{victim} mom is so fat that her shadow leaves a footprint.",
    "{victim} mom is so poor she can’t even pay attention.",
    "{victim} mom is so ugly that her mirror quit.",
    "{victim} mom is so fat it takes her two trips to haul ass.",
    "{victim} mom is so clumsy that she tripped over a cordless phone.",
    "{victim} mom is so fat her patronus is a cake.",
    "{victim} mom is so dumb that she climbed over a glass wall to see what was on the other side.",
    "{victim} mom is so fat she uses the equator as a belt.",
    "{victim} mom is so stupid she tried to climb Mountain Dew.",
    "{victim} mom is so stupid she put quarters in her ears and said she was listening to 50 Cent.",
    "{victim} mom is so fat that she can’t even jump to a conclusion.",
    "{victim} mom is so old, she has an autographed Bible.",
    "{victim} mom so fat she sat on Wal-Mart and lowered the prices!!",
    "{victim} mom is so nasty, I called her for phone sex and got an ear infection.",
    "{victim} mom so dumb she threw a rock at the ground and missed",
    "{victim} mom is so old when she was in history class they just wrote down what they were doing",
    "{victim} mom is so fat, she went to Hogwarts and got sorted into the House of Pancakes",
    "Hey now let's get off {victim} momma since we all know I got off yours last night!",
    "{victim} mom so fat, every time she turns around, it's her birthday."
]

getMomJoke = (msg, victimName) ->
    randomIndex = Math.floor(Math.random() * jokes.length)
    joke = jokes[randomIndex]
    msg.send joke.replace("{victim}", victimName);

module.exports = (robot) ->

    robot.respond /tell me about ([a-z\']+) mom/i, (msg) ->
        victim = msg.match[1]
        getMomJoke msg, victim
