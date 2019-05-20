FROM python:3.7-alpine

RUN apt-get update -y && \
    apt-get install -y nginx uwsgi uwsgi-plugin-python3

COPY ./requirements.txt /
COPY ./nginx.conf /etc/nginx/nginx.conf

WORKDIR /
RUN pip install -r /requirements.txt

COPY . /

RUN adduser --disabled-password --gecos '' nginx\  
  && chown -R nginx:nginx /app \
  && chmod 777 /run/ -R \
  && chmod 777 /root/ -R

ENTRYPOINT [ "/bin/bash", "/launcher.sh"]