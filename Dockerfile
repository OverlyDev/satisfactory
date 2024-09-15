FROM ghcr.io/overlydev/steamcmd

LABEL org.opencontainers.image.source=https://github.com/OverlyDev/satisfactory
LABEL org.opencontainers.image.description="Satisfactory dedicated server"
LABEL org.opencontainers.image.licenses=MIT

# Switch to root user for setting things up
USER root

RUN rm -rf

# Copy in scripts and make executable
COPY scripts/* /scripts/.
RUN chmod +x /scripts/*.sh

# Set up folder structure
#   /game holds the game installation from steamcmd
#   /save is a link to where Satisfactory things get saved
RUN mkdir -p /game /home/ubuntu/.config/Epic/FactoryGame/Saved/SaveGames && \
    ln -s /home/ubuntu/.config/Epic/FactoryGame/Saved/SaveGames /save && \
    chown -R ubuntu:ubuntu /game /save /home/ubuntu/.config/Epic

# Expose things
VOLUME /game
VOLUME /save
EXPOSE 7777

# Set working directory to game install path
WORKDIR /game

# Switch back to non-root user
USER ubuntu

# Set entrypoint to script
ENTRYPOINT [ "/scripts/entrypoint.sh" ]

# Default CMD (running the image with no args) will start the game server
CMD ["/scripts/run.sh"]
