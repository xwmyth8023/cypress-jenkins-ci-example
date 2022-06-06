FROM cypress/base:10

ENV APPDIR /opt/app/current

RUN \
  mkdir -p /opt/app/current && \
  mkdir -p /var/log/nodejs

WORKDIR $APPDIR

ENTRYPOINT ["docker-shell"]

CMD ["-t"]

ADD ./docker/docker-shell.sh /usr/bin/docker-shell
RUN chmod +x /usr/bin/docker-shell

ADD ./package.json $APPDIR/package.json

RUN npm install

ADD . $APPDIR