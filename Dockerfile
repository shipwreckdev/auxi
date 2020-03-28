FROM node:13.10-stretch-slim

# Variables for configuring hubot. Adjust these to fit your requirements.
ENV HUBOT_ADAPTER slack
ENV HUBOT_NAME qbert
ENV HUBOT_DESCRIPTION "Qbert is a chatops bot meant to help your development teams get things done."

# This sets the working directory for hubot.
ENV SERVICE_ROOT /home/$HUBOT_NAME

# Copy all files into the working directory and move to it.
COPY . $SERVICE_ROOT
WORKDIR $SERVICE_ROOT

# Run hubot.
CMD ./bin/hubot --adapter $HUBOT_ADAPTER --name $HUBOT_NAME