# Minimal Zephyr Devcontainer

A minimal but still privileged ubuntu devcontainer for the zephyrpoject intended for Linux based hosts.
Tested and used on Nixos

## Installation

1: Clone the repo to a location of your choosing
```git clone git@github.com:Ragebone/minimalZephyrDevcontainer.git```

2: Create a place for the zephyrproject and SDKs to live.
By default without modifying the `.devcontainer/devcontainer.json` this is expected to be a zephyrproject folder in the repos parent directory.
```mkdir ../zephyrproject```

3: Open the repo / workspace with a devcontainer enabled VSCode or VSCodium and then simply have it build and reopen inside the container.

4 optional: Complete the interactive west sdk installation questions
 
5: Add a sample or your own project files and sources to the repo, rename the project, point git to your own origin, just make it nice.

6 for Nixos: When using this on Nixos and USB passthrough is needed to debug, make sure your user is in groupID 46, usually plugdev. 

## How does this work? 

Just a plain Ubuntu container with all zephyr requirements installed.
Last step adds sourcing `env_setup.sh` into bash and zsh `.rc` files.

This script is supposed to then:
- create a python .venv inside the workdir
- install all of `wests` needed python packages
- check for and fetch the zephyrproject if it isn't present already
- execute ```west install --interactive``` if no SDKs are known to west

This should leave you in a working west environment.
All steps are checked if they are needed so opening another shell should not lead another lengthy download and install procedure.

## TODOs or things that could be nicer

- The container is currently priviledged to allow passthrough of USB devices like the rapsberry pi debug probe.
Would be great to get that working without privileges. 

- The python .venv could and probably should be externalized. Might just be another mount in the .devcontainer/devcontainer.json

- Default build and debug integrations with tasks and such for VSCode would be nice.




