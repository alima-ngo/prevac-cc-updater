#!/bin/bash

cd ../prevac-morpho-query-interface/db/
rake db:drop db:create db:structure:load
