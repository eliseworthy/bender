# Point Counter: shows how many points you have in Hungry Academy
#
# points - Ask how many points you have in Hungry Academy
#

module.exports = (robot) ->

  robot.respond /(points)(.*)/i, (msg) ->
    points = Math.floor(Math.random() * 901) 
    msg.reply points
