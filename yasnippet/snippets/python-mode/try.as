# -*- mode: snippet -*-
# name: try as
# contributor: Julio M. Alegria
# key: try
# --
try:
    $1
except ${2:Exception} as ${3:ex}:
    $0