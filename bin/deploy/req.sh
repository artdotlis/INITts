#!/bin/bash

echo "update"
dnf -y update
echo "installing requirements"
dnf -y install git make wget
echo "requirements installed"
