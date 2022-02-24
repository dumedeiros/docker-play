FROM openjdk:12-alpine

ENV PLAY_HOME /opt/play/

# Play Framework installation
RUN apk add --no-cache --quiet curl python && \
	cd /opt && \
	# Download play framework
	curl --fail --silent --show-error --location https://www.dropbox.com/s/ltn61vnyxreah9l/play.zip?dl=1 > play.zip && \
	# Extract and clean archive
	unzip -q play.zip && rm play.zip && \
	# Set execution
	chmod +x /opt/play/play
# Create application folder
RUN mkdir -p /app

WORKDIR /app

EXPOSE 9000

CMD ${PLAY_HOME}/play run /app ${ARGS}
