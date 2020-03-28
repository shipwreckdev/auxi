# Description:
#   Manages a queue of users for a specific purpose. The queue can be named, users can join it, and then mark themselves done. You can ping the first user in line and add helpful notes to describe the queue.
#   Only one queue can be configured at a time across a Slack workspace per bot instance.
#   The original intent was to allow engineers manually running a deployment queue in the absence of a shipit-esque system to do this in a way that didn't involved having to keep track of who is deploying and who is waiting.
#   You'll likely outgrow the need for this script as your engineering organization grows, but it can be helpful in the interim.
#
# Commands:
#   hubot q - show the queue
#   hubot q me - add yourself to the queue
#   hubot q done - remove yourself from the queue and tag the next person in line
#   hubot q ping - ping the first person in line in the queue for an update
#   hubot q clear - empty the queue entirely
#   hubot q define <foo> - provide a description of the queue
#   hubot q notes add <note> - add a note to the list of notes for this queue
#   hubot q notes rm <note> - remove a note from the list of notes for this queue
#   hubot q notes ls - list notes for this queue
#
# Authors:
#   Scott Hawkins

module.exports = (robot) ->
  desc = ''
  notes = []
  queue = []

  robot.respond /q clear/i, (msg) ->
    if queue.length >= 1
      queue = []

      msg.reply("Queue has been cleared!")
    else
      msg.reply("Queue is already empty.")

  robot.respond /q define (.*)/i, (msg) ->
    desc = msg.match[1]

    msg.reply("Queue description set to '#{desc}'.")

  robot.respond /q done/i, (msg) ->
    queue = queue.filter (word) -> word isnt "#{msg.message.user.name}"

    msg.reply("I removed you from the queue.")

    if queue.length >= 1
      msg.send("@#{queue[0]} - you're up!")
    else
      msg.send("Queue is now empty!")

  robot.respond /q ls/i, (msg) ->
    if queue.length < 1
      if desc != ''
        msg.reply("#{desc} is currently empty.")
      else
        msg.reply("Queue is currently empty.")
    else
      if desc != ''
        msg.reply("#{desc}: ")
      else
        msg.reply("Current queue:")

      for name in queue
        do (name) ->
          msg.send("  " + name)

  robot.respond /q me/i, (msg) ->
    queue.push "#{msg.message.user.name}"

    msg.reply("I added you to the queue.")

  robot.respond /q notes add (.*)/i, (msg) ->
    notes.push "#{msg.match[1]}"

    msg.reply("I added your note. Current notes:")

    for note in notes
      do (note) ->
        msg.send("  " + note)

  robot.respond /q notes ls/i, (msg) ->
    if notes.length >= 1
      msg.reply("Current notes:")

      for note in notes
        do (note) ->
          msg.send("  " + note)
    else
      msg.reply("Notes are currently empty.")

  robot.respond /q notes rm (.*)/i, (msg) ->
    notes = notes.filter (note) -> note isnt "#{msg.match[1]}"

    msg.reply("I removed your note. Current notes:")

    if notes.length >= 1
      msg.reply("Current notes:")

      for note in notes
        do (note) ->
          msg.send("  " + note)
    else
      msg.reply("Notes are currently empty.")

  robot.respond /q ping/i, (msg) ->
    if queue.length >= 1
      msg.send "@#{queue[0]} - are you still deploying?"
    else
      msg.reply("Queue is currently empty.")
