FROM i386/node:10-alpine as nodebuild
ARG VERSION
RUN apk --no-cache add --virtual native-deps g++ gcc libgcc libstdc++ linux-headers make python git 
RUN git clone https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt
WORKDIR /opt/zigbee2mqtt
RUN if [ $VERSION != "master" ]; then git checkout tags/$VERSION; fi
RUN npm install
FROM i386/node:10-alpine
COPY --from=nodebuild --chown=node:node /opt/zigbee2mqtt /app
USER node
WORKDIR /app
ENTRYPOINT ["npm", "start"]
