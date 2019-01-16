FROM postgres:alpine
RUN apk update && apk upgrade
RUN apk add git ncftp nodejs-npm postgresql-client mongodb-tools
RUN npm install -g redis-dump
ADD cronjob /etc/crontabs/root
ADD test /etc/periodic/15min
ADD dropbox_uploader.sh /etc/periodic/15min
ADD .dropbox_uploader /etc/periodic/15min
RUN chmod +x /etc/periodic/15min/test
CMD crond -f -l 0