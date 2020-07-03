FROM mhart/alpine-node
RUN apk add bash
RUN apk -y install nodejs
RUN apk -y install npm
RUN apk add make
RUN apk add curl
RUN apk add openssl
COPY . .
RUN make
CMD ["make","start"]