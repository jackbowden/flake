#!/bin/bash
flutter build web || exit 1
BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "$BRANCH" != "main" ]; then
  echo "Deploying to preview channel for branch: $BRANCH"
  firebase hosting:channel:deploy "$BRANCH" --expires 7d
else
  echo "Deploying to prdocution channel"
  firebase deploy
fi