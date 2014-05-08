# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#
# Test du traitement d'image  

load "../Modele/TraitementImage.rb"

taille = 20
image = TraitementImage.lire("toto.jpg")

image.traitementMonochrome()
image.display
image.traitementPixel(taille)
image.display
image.traitementMonochrome()
image.enregistrer("toto_tmp.jpg")

tmp = image.imageToPicross(taille)
tmp.afficherGrille
