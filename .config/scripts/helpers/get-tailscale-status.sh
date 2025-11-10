#!/bin/bash

if tailscale status >/dev/null 2>&1; then
   echo "1"
else
   echo "0"
fi

