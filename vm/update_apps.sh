#!/bin/bash

CCU_PATH=/var/www/prevac-cc-updater
MQI_PATH=/var/www/prevac-morpho-query-interface

cd $CCU_PATH
git pull
bundle install --deployment --without development test
bundle exec rake assets:precompile db:migrate RAILS_ENV=production

cd $MQI_PATH
git pull
bundle install --deployment --without development test

sudo apache2ctl restart

exit