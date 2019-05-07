#!/bin/bash

eval "$(ssh-agent -s)" # Start ssh-agent cache
echo here1
chmod 600 ~/.ssh/travis-git # Allow read access to the private key
echo here2
ssh-add ~/.ssh/travis-git # Add the private key to SSH
echo here3

git config --global push.default matching
git remote add deploy ssh://git@$IP:$PORT$DEPLOY_DIR
git push deploy master

# Skip this command if you don't need to execute any additional commands after deploying.
ssh apps@$IP -p $PORT <<EOF
  touch was_here.txt
EOF
#  cd $DEPLOY_DIR
#  crystal build --release --no-debug index.cr # Change to whatever commands you need!
