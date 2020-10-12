FROM openjdk:11

ENV PLAY_VERSION "1.5.3"
ENV PLAY_HOME /opt/play

# Play Framework installation
RUN cd /opt && \
	# Download play framework
	wget "https://www.dropbox.com/s/e73m06nhdfdhu9p/play.zip?dl=1" -O play.zip && \
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

#Old xecution
# Define command (entrypoint parameters)
#	- Start application located in /app directory
#	- Install dependencies on start
#	- Force port to 9000
#CMD ["run", "/app", ${DEPS}, "--http.port=9001"]
#CMD tail -f /dev/null

#New execution
# Define entrypoint
ENTRYPOINT ["/opt/play/play", "run", "/app"]

#Example of execution
#docker run image $value1 $value2 ..., $value1 and others will be "appended" after your entrypoint like 
# play run /app $value1, $value2 ....

#pratical example
#docker run image --deps --http.port=9000