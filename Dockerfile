FROM node:22-bookworm-slim

WORKDIR /app
COPY --chown=node:node package.json ./
COPY --chown=node:node app.js index.html mututsva-mark.svg server.mjs styles.css README.md ./

ENV NODE_ENV=production \
    HOST=0.0.0.0 \
    DB_PATH=/data/mututsva.sqlite

RUN mkdir -p /data && chown node:node /data
USER node

EXPOSE 3000
VOLUME ["/data"]
CMD ["npm", "start"]
