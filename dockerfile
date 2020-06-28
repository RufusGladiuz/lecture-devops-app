FROM mhart/alpine-node
RUN apk add bash
RUN apk add make
RUN apk add curl
RUN apk add openssl
COPY . .
RUN make
CMD ["make","start"]