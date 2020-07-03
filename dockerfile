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
# USER jenkins