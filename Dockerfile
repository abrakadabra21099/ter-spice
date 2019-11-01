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
RUN echo 'LANG=ru_RU.UTF-8' >> /etc/default/locale && \
	apt-get -q=3 -y --show-progress install task-mate-desktop task-print-server task-ssh-server \
	xserver-xspice xserver-xorg-video-qxl spice-vdagent lightdm && \
	rm -rf /var/lib/apt/lists/* 
RUN useradd -m u00023 && echo -e '123\n123' | passwd -q u00023
COPY xorg.conf /etc/X11/
#CMD ["/bin/bash"]
CMD ["/bin/su", "-c", "/usr/bin/Xspice --disable-ticketing --port 5900 :0.0", "u00023"]
#CMD ["/bin/su", "-c", "/usr/bin/startx", "u00023"]
#CMD ["/bin/su", "-c", "/etc/X11/Xsession", "u00023"]
#CMD ["/usr/bin/startx"]
