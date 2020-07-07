FROM node:12
WORKDIR /devops
COPY . .
WORKDIR /devops/app/client
RUN npm install
RUN npm run build
RUN mv build /lecture-devops-app/app/server/src/public
WORKDIR /devops/app/server
RUN npm install
EXPOSE 3000

RUN npm install env-cmd

CMD [ "/bin/sh", "-c" , "npm start --silent" ]


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
# FROM node
# USER root
# RUN apt-get update
# RUN apt-get -y install curl
# RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
# COPY . .
# COPY package*.json ./
# RUN cd app/client
# RUN npm install
# CMD ["node", "scripts/build.js"]
# RUN cd app/server
# RUN npm install
# CMD ["node", "env-cmd -f ./dev.env nodemon src/index.js"]
# USER node
# FROM node:10-alpine
# USER root
# WORKDIR /app
# COPY /app/client/package.json /app
# RUN npm install
# COPY /app/client/ /app
# EXPOSE 3000
# CMD [ "node", "scripts/build.js" ]

# FROM node:12
# WORKDIR devops/app/client
# RUN npm install
# RUN npm run build
# WORKDIR devops/app/server
# RUN npm install
# EXPOSE 3000

# RUN npm install env-cmd

# CMD [ "/bin/sh", "-c" , "npm start --silent" ]

