RUN apk --no-cache add tini nodejs-npm yarn

ARG PROJ_ROOT=/usr/local
ARG COMMIT=master
ARG PROJ_DESTINATION=$PROJ_ROOT/gitproj
ARG ORG=CymaticLabs
ARG PROJ=GrafanaSimpleJsonValueMapper
ARG GIT_URL=https://github.com/$ORG/$PROJ/archive/$COMMIT.zip
ADD $GIT_URL $PROJ_DESTINATION/

WORKDIR $PROJ_DESTINATION

RUN unzip $COMMIT.zip -qq && rm $COMMIT.zip && mv $PROJ-* $PROJ;

WORKDIR $PROJ_DESTINATION/$PROJ

# npm fails to connect on Ubuntu host, somehow. Possible Docker bug; doesn't occur on macOS host.
# RUN npm install;
RUN yarn install;

COPY data.json server/

# TODO: make clean-up routine. Can remove yarn at this point.

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/usr/bin/npm", "run", "start"]