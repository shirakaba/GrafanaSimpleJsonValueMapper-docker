# docker build . --tag=jsonmapper
# docker build . --build-arg COMMIT=ce0999b342f4e8e861509e7ce3def5d9a7debf10 --tag=jsonmapper

# docker run -it --rm -p 3003:3003 jsonmapper

FROM alpine:3.7

EXPOSE 3003

RUN apk --no-cache add tini nodejs-npm

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

RUN npm install;

COPY data.json server/

# TODO: make clean-up routine.

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/usr/bin/npm", "run", "start"]