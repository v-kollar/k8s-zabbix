#!/bin/bash

mysql -sfu root <<EOS
set global log_bin_trust_function_creators = 0;

EOS
