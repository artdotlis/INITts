#!/bin/bash

echo "update"
dnf -y update
echo "installing requirements"
dnf -y install git git-lfs make gcc-c++
echo "requirements installed"
