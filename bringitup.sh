#!/bin/bash

cd vx_simulation
vagrant up oob-mgmt-server oob-mgmt-switch
sleep 10
vagrant up
