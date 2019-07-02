FROM postgres:alpine
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.9/main" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.9/community" >> /etc/apk/repositories
RUN apk update && apk upgrade
RUN apk add git ncftp nodejs-npm curl postgresql-client mongodb-tools
RUN npm install -g redis-dump
ADD cronjob /etc/crontabs/root
ADD test /etc/periodic/15min
ADD dropbox_uploader.sh /etc/periodic/15min
ADD .dropbox_uploader /etc/periodic/15min
RUN chmod +x /etc/periodic/15min/test
CMD crond -f -l 0
