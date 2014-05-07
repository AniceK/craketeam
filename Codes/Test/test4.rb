# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#
# Test du traitement d'image  

load "TraitementImage.rb"

taille = 10
image = TraitementImage.lire("toto.jpg")

image.traitementMonochrome()
image.display
image.traitementPixel(taille)
image.display
