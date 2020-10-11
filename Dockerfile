FROM openjdk:11

ENV PLAY_VERSION "1.5.3"
ENV PLAY_HOME /opt/play

# Play Framework installation
RUN cd /opt && \
	# Download play framework
	wget https://srv-file9.gofile.io/downloadStore/srv-store5/WY5BN0/play.zip && \
	# Extract and clean archive
	unzip -q play.zip && rm play.zip && \
	# Set execution
	chmod +x /opt/play/play
# Create application folder
RUN mkdir -p /app

WORKDIR /app

EXPOSE 9000

HEALTHCHECK --interval=30s --timeout=3s \
	CMD curl --fail http://localhost:9000/ || exit 1

# Define entrypoint
ENTRYPOINT ["/opt/play/play"]
# Define command (entrypoint parameters)
#	- Start application located in /app directory
#	- Install dependencies on start
#	- Force port to 9000
CMD ["run", "/app", "--http.port=9000"]