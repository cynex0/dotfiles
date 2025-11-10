#!/bin/bash

PIA_STATE=$(/usr/local/sbin/piactl get connectionstate)
echo "$PIA_STATE"
