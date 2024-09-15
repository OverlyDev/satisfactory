IMAGE := overlydev/satisfactory

# Build the image
image:
	docker build -t $(IMAGE) .

# Variables for running the image
GAME_VOLUME := -v $(shell pwd)/game:/game
SAVE_VOLUME := -v $(shell pwd)/save:/save
PORTS := -p 7777:7777/tcp -p 7777:7777/udp

# Run the image
run:
	mkdir -p ./game ./save && docker run --rm -it --name satisfactory $(GAME_VOLUME) $(SAVE_VOLUME) $(PORTS) $(IMAGE)

# Cleanup mounted folders
clean:
	rm -rf game save
