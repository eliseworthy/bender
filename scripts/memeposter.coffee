# MemePoster is the fastest way to get Hungry Academy Memes out to the world!
#
# post <image url> - puts an image on hungryacademymemes.com

request = require 'request'

module.exports = (robot) ->

  robot.respond /post( (\S+))?/i, (msg) ->
    meme_value = msg.match[2] 
    
    options =  
      uri: 'http://memer.herokuapp.com/images' 
      json:
        picture: meme_value

    request.post options, (err, resp, body) ->
      console.log "err: ", err
      console.log "resp: ", resp
      console.log "body: ", body
      msg.send body.picture