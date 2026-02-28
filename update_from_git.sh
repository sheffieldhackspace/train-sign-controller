#!/bin/bash

export GIT_SSH_COMMAND="ssh -i /usr/shhm/.ssh/trainsigncontroller-deploy-key"
git pull
