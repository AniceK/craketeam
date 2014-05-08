# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#
# Test du traitement d'image  

load "../Modele/TraitementImage.rb"

#Meilleur résultat sur de grande taille
taille = 20
image = TraitementImage.lire("test.jpg")

image.routine(taille)
image.enregistrer("test_tmp.jpg")

tmp = image.afficherGrille()
puts tmp