# base image
FROM node:12.2.0-alpine

WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

COPY ../../node/package.json /app/package.json

CMD ["npm", "start"]

EXPOSE 3000