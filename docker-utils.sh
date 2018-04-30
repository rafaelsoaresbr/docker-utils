#!/bin/bash

COMPOSE_VER="1.21.0"
MACHINE_VER="v0.14.0"
KUBECTL_VER="v1.10.2"
MINIKUBE_VER="v0.26.1"
MINISHIFT_VER="1.16.1"

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

# minikube/kubectl
curl -L https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VER/bin/linux/amd64/kubectl -o "$HOME"/bin/kubectl
curl -L https://storage.googleapis.com/minikube/releases$MINIKUBE_VER/minikube-linux-amd64 -o "$HOME"/bin/minikube

# minishift
curl -L https://github.com/minishift/minishift/releases/download/v$MINISHIFT_VER/minishift-$MINISHIFT_VER-linux-amd64.tgz | tar xz -C "$HOME"/bin
mv "$HOME"/bin/minishift-$MINISHIFT_VER-linux-amd64/minishift "$HOME"/bin/minishift
rm -r "$HOME"/bin/minishift-$MINISHIFT_VER-linux-amd64

cat <<EOF >> "$HOME"/.bashrc
# docker-machine/docker-compose
if ! shopt -oq posix; then
  if [ -d "$HOME"/bin/bash_completion.d ]; then
    for f in "$HOME"/bin/bash_completion.d/*; do
      . $f
    done
  fi
fi
# kubectl
. <(kubectl completion bash)
EOF

chmod +x "$HOME"/bin/docker-* "$HOME"/bin/kubectl "$HOME"/bin/mini*

echo -e Finished!
