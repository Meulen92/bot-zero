FROM node:alpine

LABEL maintainer "ictdba@wehkamp.nl"

# Define the arguments
ARG EXPRESS_PORT
ARG HUBOT_SLACK_TOKEN

# See whether HUBOT_SLACK_TOKEN is set 
RUN if [ -z "$HUBOT_SLACK_TOKEN" ]; then echo "You forgot: --build-arg HUBOT_SLACK_TOKEN=your_slack_token"; exit 1; else : ; fi

# Copy the hubot code into the container
COPY . /opt/service/

# Change to the work directory
WORKDIR /opt/service

# Set environment variables
ENV EXPRESS_PORT=$EXPRESS_PORT
ENV HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN

# Build the hubot
RUN npm install

# Set the enviroment variables in .env file
RUN echo JENKINS_API_TOKEN=$JENKINS_API_TOKEN >> .env

# Start the hubot
ENTRYPOINT ["/usr/local/bin/npm", "start"]
