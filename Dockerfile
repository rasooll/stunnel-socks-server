FROM alpine:3.12
RUN apk update && apk add stunnel
WORKDIR /etc/stunnel
COPY secrets.txt /etc/stunnel/
COPY stunnel.conf /etc/stunnel/
RUN chmod 400 /etc/stunnel/secrets.txt
EXPOSE 1080
CMD /usr/bin/stunnel /etc/stunnel/stunnel.conf