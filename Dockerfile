FROM node:13.10-stretch-slim

ENV SERVICE_ROOT /home/auxi
ENV HUBOT_ADAPTER slack
ENV HUBOT_NAME auxi
ENV HUBOT_DESCRIPTION "Auxi is a chatops bot meant to help your development teams get things done."

COPY . $SERVICE_ROOT

WORKDIR $SERVICE_ROOT

CMD ./bin/hubot --adapter $HUBOT_ADAPTER --name $HUBOT_NAME