FROM postgres:10

COPY *.sh /var/lib/postgresql/

RUN rm -f /etc/apt/sources.list.d/pgdg.list

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y install wget iputils-ping && \
#    wget https://github.com/zubkov-andrei/pg_profile/releases/download/0.3.6/pg_profile--0.3.6.tar.gz && \
#    wget https://github.com/zubkov-andrei/pg_profile/releases/download/4.1/pg_profile--4.1.tar.gz && \
    https://github.com/zubkov-andrei/pg_profile/releases/download/4.2/pg_profile--4.2.tar.gz && \
    tar xzf pg_profile--4.1.tar.gz --directory $(pg_config --sharedir)/extension && \
    apt-get -y purge wget && \
    apt-get update && \
    apt-get clean all && \
    apt-get -y autoremove --purge && \
    unset DEBIAN_FRONTEND && \
    chown 999:999 /var/lib/postgresql/*.sh && \
    chmod 700 /var/lib/postgresql/*.sh && \
    echo 'alias nocomments="sed -e :a -re '"'"'s/<\!--.*?-->//g;/<\!--/N;//ba'"'"' | sed -e :a -re '"'"'s/\/\*.*?\*\///g;/\/\*/N;//ba'"'"' | grep -v -P '"'"'^\s*(#|;|--|//|$)'"'"'"' >> ~/.bashrc

WORKDIR /var/lib/postgresql
