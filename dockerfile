# FROM mhart/alpine-node
# RUN apk add bash
# RUN apk add nodejs
# RUN apk add npm
# RUN apk add make
# RUN apk add curl
# RUN apk add openssl
# COPY . .
# RUN make
# CMD ["make","start"]
FROM node
USER root
RUN apt-get update
RUN apt-get -y install curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
COPY . .
RUN cd app/client
RUN npm install
CMD ["node", "scripts/build.js"]
RUN cd app/server
RUN npm install
CMD ["node", "env-cmd -f ./dev.env nodemon src/index.js"]
# USER jenkins