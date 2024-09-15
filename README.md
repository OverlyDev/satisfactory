# Satisfactory Server

This repo provides an image for running a Satisfactory dedicated server:

- `ghcr.io/overlydev/satisfactory`

The image should rebuild every day at midnight to keep things fresh.

## Usage

To use this container, follow the `run` target in the `Makefile` and adapt to your environment.

At a basic level, the container exposes/provides:
- Port `7777`, `tcp` and `udp`
- `/game`, where the game is installed to
- `/save`, where the saves are stored

The above items should be exposed on the host side as applicable.

## Local Testing

This repo can be cloned locally for building/testing the image, all that's required is `docker` and `make`.

A general overview of the workflow is:

- Clone the repo
- Execute `make image` to build the image
- Execute `make run` to run the image

`Makefile` notes:

- The `IMAGE` variable is set to `overlydev/satisfactory`, which is what the built image gets tagged as
    - This can be modified as needed.
- There's a couple variables set for running the image:

    - `GAME_VOLUME` - Contains the installed game. Useful to mount so the container doesn't have to install the game every time it starts
        - Host-side (left of `:`) is set to `<current directory>/game`
            - This can be modified as needed
        - Container-side (right of `:`) is set to `/game`
            - This shouldn't be modified without making equivalent changes to the `Dockerfile`

    - `SAVE_VOLUME` - Contains the saved games. Useful to persist saves between container start/stop/restart.
        - Host-side (left of `:`) is set to `<current directory>/save`
            - This can be modified as needed
        - Container-side (right of `:`) is set to `/save`
            - This is a link to the path in the user's home directory where Satisfactory saves things
            - This shouldn't be modified without making equivalent changes to the `Dockerfile`

    - `PORTS` - Contains the port bindings
        - Currently, the image has no mechanism for specifying ports and only runs on the default of `7777`
        - These should be bound on the host-side as `tcp` and `udp`
