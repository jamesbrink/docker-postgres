# PostgtreSQL
#
# VERSION       1.0

FROM ubuntu
MAINTAINER James Brink, brink.james@gmail.com

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y postgresql
RUN apt-get install -y postgis
RUN apt-get install -y postgresql-client

USER postgres

# Initial default user/pass and schema
ENV ROLE docker
ENV PASSWORD docker
ENV SCHEMA docker

RUN echo "listen_addresses='*'" >> /etc/postgresql/9.1/main/postgresql.conf
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.1/main/pg_hba.conf

VOLUME	["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
ADD ./postgres.sh /var/lib/postgresql/postgres.sh
EXPOSE 5432
CMD ["/var/lib/postgresql/postgres.sh"]

