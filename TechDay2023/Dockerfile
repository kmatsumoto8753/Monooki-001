FROM 516272904783.dkr.ecr.ap-northeast-1.amazonaws.com/django-app:latest

WORKDIR /var/www/
COPY ./mysite ./mysite
COPY ./newrelic.ini ./

ARG CMTID
ENV NRCMT=${CMTID}

CMD NEW_RELIC_METADATA_COMMIT=${NRCMT} NEW_RELIC_CONFIG_FILE=newrelic.ini newrelic-admin run-program  python3 mysite/manage.py runserver 0.0.0.0:8000