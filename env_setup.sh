#!/bin/bash

if [ ! -d "$PWD/.venv" ]; then
  python3 -m venv $PWD/.venv
fi

if [ ! -d "$PWD/.venv" ]; then
  echo "ERROR no venv is setup, not sure why"
fi

source "$PWD/.venv/bin/activate" 

ZEPHYR_DIRECTORY = $ZEPHYR_BASE/..
ZEPHYR_WEST_DIRECTORY = $ZEPHYR_DIRECTORY/.west

if [ ! -d $ZEPHYR_WEST_DIRECTORY ]; then
  echo "Zephyr is not setup yet; running west init and update"
  west init $ZEPHYR_DIRECTORY
  if [ ! -f "$ZEPHYR_WEST_DIRECTORY/config" ]; then
    echo "west config is missing, something went seriously wrong"
    return 0
  fi
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
