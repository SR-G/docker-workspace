FROM	greyltc/archlinux

WORKDIR	/opt
VOLUME	["/data"]
EXPOSE	8080

CMD	["/usr/bin/mopidy"]

ADD 	mopidy.conf /root/.config/mopidy/

RUN	pacman -Sy --noconfirm base-devel python2-pip gst-python2 gst-plugins-good gst-plugins-ugly && \
	pip2 install -U mopidy && \
	pip2 install Mopidy-Plex Mopidy-WebSettings Mopidy-Mobile Mopidy-Subsonic Mopidy-Mopify Mopidy-Moped Mopidy-Simple-Webclient Mopidy-SoundCloud 
# Mopidy-Spotify-Web
# Mopidy-File Mopidy-HTTP Mopidy-Local Mopidy-M3U Mopidy-MPD Mopidy-SoftwareMixer Mopidy-Stream
