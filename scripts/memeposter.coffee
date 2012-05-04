# MemePoster is the fastest way to get Hungry Academy Memes out to the world!
#
# post <image url> - puts an image on hungryacademymemes.com

module.exports = (robot) ->

  robot.respond /post( (\S+))?/i, (msg) ->
    post = msg.match[2] 
    msg.send post



