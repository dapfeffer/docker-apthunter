#Dockerfile vars

#vars
IMAGENAME=apthunter
TIMESTAMP:=$(shell date +%Y%m%d)
#VERSION=0.1.1
#VERSION=${TIMESTAMP}
VERSION=$(shell git describe --always)
REPO=dapfeffer
IMAGEFULLNAME=${REPO}/${IMAGENAME}:${VERSION}
IMAGELATEST=${REPO}/${IMAGENAME}:latest
IMAGEBASE=${REPO}/${IMAGENAME}:base

.PHONY: help build push all

help:
	    @echo "Makefile arguments:"
	    @echo ""
	    @echo "Makefile commands:"
	    @echo "build"
	    @echo "push"
	    @echo "all"

.DEFAULT_GOAL := build

base:
	    @docker build --pull -t ${IMAGEBASE} -f Dockerfile.base .
	    @docker push ${IMAGEBASE}

build:
	    @docker build --pull -t ${IMAGEFULLNAME} -f Dockerfile .
	    @docker tag ${IMAGEFULLNAME} ${IMAGELATEST}
push:
	    @docker push ${IMAGEFULLNAME}
	    @docker push ${IMAGELATEST}


all: build push
