FROM node:12
WORKDIR /devops
COPY . .
WORKDIR /devops/app/client
RUN npm install
RUN npm run build
RUN mv build /devops/app/server/src/public
WORKDIR /devops/app/server
RUN npm install
EXPOSE 3000

RUN npm install env-cmd

CMD [ "/bin/sh", "-c" , "npm start --silent" ]
