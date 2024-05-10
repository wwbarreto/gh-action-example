FROM node:20.9.0-buster AS base
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
  curl unzip wget \
  git
RUN yarn global add @angular/cli@17.1.0

RUN echo 'set +o history' >> /etc/profile

FROM base AS permissions
ARG REPO_PATH=/var/www
RUN mkdir ${REPO_PATH}
RUN chown -R node:node ${REPO_PATH}

FROM permissions AS dependencies
WORKDIR ${REPO_PATH}
USER node
RUN ng config -g cli.packageManager yarn
COPY --chown=node:node ./package.json ${REPO_PATH}/package.json
COPY --chown=node:node ./yarn.lock ${REPO_PATH}/yarn.lock
RUN yarn install

FROM dependencies AS develop
USER node
WORKDIR ${REPO_PATH}

EXPOSE 4200

CMD [ "yarn", "start" ]
