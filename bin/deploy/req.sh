#!/bin/bash

echo "update"
dnf -y update
echo "installing requirements"
dnf -y install git make gcc-c++
echo "requirements installed"
