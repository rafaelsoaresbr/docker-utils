#!/bin/bash

COMPOSE_VER="1.21.0"
MACHINE_VER="v0.14.0"

mkdir -p "$HOME"/bin/bash_completion.d

# docker-compose
curl -L https://github.com/docker/compose/releases/download/$COMPOSE_VER/docker-compose-"$(uname -s)"-"$(uname -m)" -o "$HOME"/bin/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/$COMPOSE_VER/contrib/completion/bash/docker-compose -o "$HOME"/bin/bash_completion.d/docker-compose

# docker-machine
BASE=https://raw.githubusercontent.com/docker/machine/$MACHINE_VER/contrib/completion/bash
curl -L $BASE/docker-machine-"$(uname -s)"-"$(uname -m)" >"$HOME"/bin/docker-machine
chmod +x ~/bin/docker-machine
for i in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash
do
  wget $BASE/$i -P "$HOME"/bin/bash_completion.d
done

chmod +x "$HOME"/bin/docker-*

echo -e Finished!
