# Description:
#   Manages a queue of users for a specific purpose.
#
# Commands:
#   hubot q - show the queue
#   hubot q me - add yourself to the queue
#   hubot q done - remove yourself from the queue
#
# Authors:
#   Scott Hawkins

module.exports = (robot) ->
  desc = ""
  queue = []

  robot.respond /q ls/i, (msg) ->
    if queue.length < 1
      msg.reply("Queue is currently empty.")
    else
      msg.reply("Current queue: ")

      for name in queue
        do (name) ->
          msg.send("  " + name)

  robot.respond /q me/i, (msg) ->
    queue.push "#{msg.message.user.name}"

    msg.reply("I added you to the queue.")

  robot.respond /q done/i, (msg) ->
    queue = queue.filter (word) -> word isnt "#{msg.message.user.name}"

    msg.reply("I removed you from the queue.")

  robot.respond /q define (.*)/i, (msg) ->
    desc = msg.match[1]

    msg.reply("Queue description set to '#{desc}'.")

  robot.respond /q clear/i, (msg) ->
    storedQueue = queue

    queue = []

    msg.reply("Queue has been cleared!")

  robot.respond /q ping/i, (msg) ->
    if queue.length < 1
      msg.send "@#{queue[0]} - are you still deploying?"
    else
      msg.reply("Queue is currently empty.")
