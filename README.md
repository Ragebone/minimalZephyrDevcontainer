# Minimal Zephyr Devcontainer

A minimal plain ubuntu based devcontainer for the zephyrpoject to easily and quickly get a [freestanding](https://docs.zephyrproject.org/latest/develop/application/index.html#zephyr-freestanding-app) app up and running.

Admitedly there are mutliple devcontainers out in the wild already.

Where this is supposed to shine is its simplicity by:

- using a plain ubuntu docker image
- a short shell script to setup python, west and the rest most leniently
- a focus on freestanding application development

Tested and used on Nixos; Other host OSes might experience issues.


## Installation

`1` Clone the repo to a location of your choosing and move into it 
```
git clone git@github.com:RageboneminimalZephyrDevcontainer.git
```
```
cd minimalZephyrDevcontainer
```

`2` Create a place for the zephyrproject and SDKs to live.
By default this is expected to be a `zephyrproject` directory parallel to the repository, a folder in the repos parent directory.
This can be changed by modifying the mounts in the `.devcontainer/devcontainer.json`.

```
mkdir ../zephyrproject
```

`3` Open the repository or workspace with a devcontainer capable IDE like VSCode or VSCodium and then simply have it build and reopen inside the container.
This can be done either through the `popup` that there is a devcontainer present or through

```
ctrl + shift + p 
```
```
> Rebuild and open in container
```
Or some such command in VSCode and VSCodium. 

First time opening will cause west to interactively install the SDK.

`3+` complete those interactive questions; when in doubt, say yes to everything.
 
`4` Add a sample or your own project files and sources to the repo, rename the project, point git to your own remote, just make it nice.

`5` When using this on Nixos and USB passthrough is needed to debug, make sure your user is in group `plugdev` and that `plugdev` has the groupID 46.
The name doesn't actually matter but it needs to be groupID 46 to match ubuntus group inside the container.  

## How does this work? 

Just a plain Ubuntu container with all zephyr requirements installed.

Last step adds sourcing `env_setup.sh` into bash and zsh `.rc` files.

It is effectively the [getting started](https://docs.zephyrproject.org/latest/develop/getting_started/index.html) guide as a bash script with added checks to skipp steps.

This script is supposed to then:

- create a python .venv inside the zephyrproject directory
- install all of `wests` needed python packages
- check for and fetch the zephyrproject if it isn't present already
- execute ```west install --interactive``` if no SDKs are known to west

This should leave you in a working west environment.

All steps are checked if they are needed so opening another shell should not lead to another lengthy download and install process.

## TODOs or things that could be nicer

- The container is currently priviledged to allow usage of passed through USB devices like the rapsberry pi debug probe.
Would be great to get that working without privileges. 

- Default build and debug integrations with tasks and such for VSCode would be nice.

- proper code highlighting and such.

- reasonable list of default extensions 

- a script or command that renames the repo, workspace and optionally container as well as changes the git remote

- better checks for for example `west` presence so that `pip install west` and dependencie installations can be skipped.

- `.devcontainter/devcontainer.json` bind mounts the `zephyrproject` directory and will fail completely if it isn't present. Would be cool if it would be lenient or even create that directory. Or stop and ask to create that directory on the host.

- `.devcontainter/devcontainer.json` bind mounts the `/dev/bus/usb` directory for accessing hw debuggers like the raspberry pi debug probe. Would be good if this worked on other setups as well.


## Other devcontainers and reference material

- https://embedded-house.ghost.io/zephyr-with-dev-containers/  This looks promissing 

- https://github.com/digiexchris/Zephyr-RTOS-DevContainer i think i used this one before. My biggest issue i remember was that the hole setup was happening inside the Dockerfile. Meaning, building the image takes ages and is super difficult to debug. None of the steps can be cached or skipped so its repetetively taking ages.

- https://github.com/cooked/vscode-zephyr-devcontainer/blob/master/.devcontainer/devcontainer.json
i used this one for a while but only after spending some time getting it to build and work. 

- https://dev.blues.io/blog/zephyr-debugging-feather-mcus/  Still need to look at this