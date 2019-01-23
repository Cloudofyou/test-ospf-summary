#!/bin/bash

cd topology_converter
vagrant up oob-mgmt-server oob-mgmt-switch
sleep 10
vagrant up
