
if [ ! -d "/home/ubuntu/workdir/.venv" ]; then
  python3 -m venv /home/ubuntu/workdir/.venv
fi

if [ ! -d "/home/ubuntu/workdir/.venv" ]; then
  echo "ERROR no venv is setup, not sure why"
  exit 0
fi

source "/home/ubuntu/workdir/.venv/bin/activate" 

pip install west
