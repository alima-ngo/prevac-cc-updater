#!/bin/bash

cp db/structure.sql ../prevac-morpho-query-interface/db/
cd ../prevac-morpho-query-interface/db/
rake db:drop
rake db:create
rake db:structure:load
