# Point Counter: shows how many points you have in Hungry Academy
#
# points <query> - Ask how many points you have
#

dice = Math.floor(Math.random() * 6) + 1

module.exports = (robot) ->
  robot.respond /(dice)(.*)/i, (msg) ->
    msg.reply msg.dice
