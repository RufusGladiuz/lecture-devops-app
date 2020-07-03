FROM mhart/alpine-node
RUN apk add bash
RUN apt-get -y install nodejs
RUN apt-get -y install npm
RUN apk add make
RUN apk add curl
RUN apk add openssl
COPY . .
RUN make
CMD ["make","start"]