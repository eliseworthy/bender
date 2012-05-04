# Yo doggie <text> so <text> - Generates Yo Dawg

request = require 'request'

module.exports = (robot) ->
  robot.respond /(TEST .*) (SO .*)/i, (msg) ->
    memeGenerator msg, 970994, 4316452, msg.match[1], msg.match[2], (url) ->
      options =  
        uri: 'http://memer.herokuapp.com/images' 
        json:
          picture: url

      request.post options, (err, resp, body) ->
        console.log "err: ", err
        console.log "resp: ", resp
        console.log "body: ", body
        msg.send body.picture

memeGenerator = (msg, generatorID, imageID, text0, text1, callback) ->
  username = process.env.HUBOT_MEMEGEN_USERNAME
  password = process.env.HUBOT_MEMEGEN_PASSWORD
  preferredDimensions = process.env.HUBOT_MEMEGEN_DIMENSIONS

  unless username? and password?
    msg.send "MemeGenerator account isn't setup. Sign up at http://memegenerator.net"
    msg.send "Then ensure the HUBOT_MEMEGEN_USERNAME and HUBOT_MEMEGEN_PASSWORD environment variables are set"
    return

  msg.http('http://version1.api.memegenerator.net/Instance_Create')
    .query
      username: username,
      password: password,
      languageCode: 'en',
      generatorID: generatorID,
      imageID: imageID,
      text0: text0,
      text1: text1
    .get() (err, res, body) ->
      result = JSON.parse(body)['result']
      if result? and result['instanceUrl']? and result['instanceImageUrl']? and result['instanceID']?
        instanceID = result['instanceID']
        instanceURL = result['instanceUrl']
        img = result['instanceImageUrl']
        msg.http(instanceURL).get() (err, res, body) ->
          # Need to hit instanceURL so that image gets generated
          if preferredDimensions?
            callback "http://images.memegenerator.net/instances/#{preferredDimensions}/#{instanceID}.jpg"
          else
            callback "http://images.memegenerator.net/instances/#{instanceID}.jpg"
      else
        msg.reply "Sorry, I couldn't generate that image."      