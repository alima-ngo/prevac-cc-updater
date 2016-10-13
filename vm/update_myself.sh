#!/bin/bash

if [ -e update_apps_new.sh ] ; then
  mv update_apps_new.sh update_apps.sh
  chmod +x update_apps.sh
fi
