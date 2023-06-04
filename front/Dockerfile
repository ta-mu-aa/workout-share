FROM node:16.13.2-alpine

ARG WORKDIR

ENV HOME=/${WORKDIR}

WORKDIR ${HOME}

COPY ./package.json .
RUN apk update && npm install -g npm

CMD ["npm", "run", "dev"]
