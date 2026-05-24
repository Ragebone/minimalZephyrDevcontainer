#!/bin/bash

WORK_DIR=$HOME/workdir
ZEPHYR_DIRECTORY=$HOME/zephyrproject
WEST_DIRECTORY=$ZEPHYR_DIRECTORY/.west
VENV_DIR=$ZEPHYR_DIRECTORY/.venv
ZEPHYR_SDK_INSTALL_DIR=$ZEPHYR_DIRECTORY

if [ ! -d "$VENV_DIR" ]; then
  echo "installing new venv to $VENV_DIR"
  python3 -m venv "$VENV_DIR"
fi

if [ ! -d "$VENV_DIR" ]; then
  echo "ERROR no venv is setup in $VENV_DIR, not sure why"
fi

source "$VENV_DIR/bin/activate" 

pip install west

echo "installed pip"

if [ ! -d $WEST_DIRECTORY ]; then
  echo "Zephyr is not setup yet; running west init and update"
  west init $ZEPHYR_DIRECTORY
  if [ ! -f $WEST_DIRECTORY/config ]; then
    echo "west config is missing, something went seriously wrong initializing west"
    return 0
  fi

  echo "updating west, packages and calling zephyr-export"
  
  west update
  west packages pip --install
  west zephyr-export
fi

if west sdk list >/dev/null 2>&1; then
  # SDK already present
  return 0
fi

echo "No Zephyr SDKs found — checking SDK folders ... "

for d in "$ZEPHYR_SDK_INSTALL_DIR"/*/; do
  [ -f "${d}setup.sh" ] || continue
  "${d}setup.sh" -c
done

if west sdk list >/dev/null 2>&1; then
  # SDK is now available
  return 0
fi

echo "No Zephyr SDKs found — installing interactively"

west sdk install -i --install-base $ZEPHYR_SDK_INSTALL_DIR
