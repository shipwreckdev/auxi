# Description:
#   Resets all flipped tables to prevent chaos and destruction.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   ┻━┻
#
# Author:
#   cadwallion

module.exports = (robot) ->
  robot.hear /┻━┻/i, (msg) ->
    msg.send '┬─┬ノ( º _ ºノ) chill out yo'
  robot.hear /\(tableflip\)/i, (msg) ->
    msg.send '┬─┬ノ( º _ ºノ) chill out yo'
