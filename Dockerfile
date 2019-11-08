FROM alpine:latest
RUN apk add --update nodejs npm git build-base gcc wget python

WORKDIR /
COPY package.json bower.json Gruntfile.coffee /
RUN mkdir /backup && mkdir /logs && mkdir /uploads
VOLUME data
RUN npm install -g modclean
RUN npm install && npm install -g bower grunt-cli && modclean -r -n default:safe,default:caution && npm uninstall -g modclean
RUN bower install --allow-root
COPY src/ /src
RUN grunt build
RUN rm -rf bower_components/
COPY /env.sh .

ENV NODE_ENV=production
ENV PORT=4444

EXPOSE 4444
CMD . env.sh && node --expose-gc server/app.js