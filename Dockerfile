FROM debian:10
LABEL maintainer="4i! aka \$oRRy"
LABEL description="Graphical terminal based on Xspice."
ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i s%/deb\.debian\.org/%/mirror.yandex.ru/% /etc/apt/sources.list && apt-get update && \
	apt-get -q=3 -y --show-progress install locales bash-completion && \
        localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
#&& \
ENV LANG ru_RU.UTF-8
#	tasksel --debconf-apt-progress "--no-progress" install print-server ssh-server mate-desktop && \
#tasksel \
RUN apt-get -q=3 -y --show-progress install task-mate-desktop task-print-server task-ssh-server
RUN apt-get -q=3 -y --show-progress install xserver-xspice xserver-xorg-video-qxl
COPY xorg.conf /etc/X11/
RUN rm -rf /var/lib/apt/lists/* 
CMD ["/usr/bin/startx"]
