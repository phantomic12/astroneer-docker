FROM ubuntu:22.04

ENV TIMEZONE=Europe/Rome \
    DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    dpkg --add-architecture i386 && \
    apt install -y software-properties-common

RUN set -x \
    && echo steam steam/question select "I AGREE" | debconf-set-selections

RUN add-apt-repository -y multiverse && \
    apt install -y flatpak lib32gcc-s1 steamcmd

RUN \
    /usr/games/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /astroneer +login anonymous +app_update 728470 validate +quit

RUN \
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo \
    && flatpak install -y com.valvesoftware.Steam.CompatibilityTool.Proton-GE

ENV STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.steam/steam/ \
  STEAM_COMPAT_DATA_PATH=$HOME/.steam/steam/steamapps/compatdata/728470

RUN mkdir -p $STEAM_COMPAT_DATA_PATH


RUN apt install -y winetricks pulseaudio curl crudini

RUN winetricks sound=pulse

RUN usermod -aG pulse,pulse-access root

EXPOSE 30877/tcp
EXPOSE 30877/udp

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/astroneer/Astro/Saved/SaveGames"]

ENTRYPOINT ["/entrypoint.sh"]

