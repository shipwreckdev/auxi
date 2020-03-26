# Description:
#   Utility commands for checking the hubot version.
#
# Commands:
#   hubot version - shows hubot version

module.exports = (robot) ->
  robot.respond /version/i, (msg) ->
    msg.send robot.version
