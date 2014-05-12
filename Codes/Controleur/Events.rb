# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require './Modele/Profil'
require './Modele/Jeu'


#===============================================================================#
#                                                                               #
#               La classe Events n'est pas instantiable.                        #
#  Elle permet de créer des évènements qui controleront l'interface graphique   #
#                                                                               #
#===============================================================================#

class Events
  
  @jeu
  @fenetre
  @eventsCourants
  
  attr_reader :jeu, :fenetre, :eventsCourants
  
  private_class_method :new
  
# On transmet les données du jeu entre les évènements
  def initialize(jeu)
    
    @jeu = jeu
  end

# On change l'évènement à prendre en compte dans le jeu lors d'un changement de fenêtre
  def mouvement(events)
    
    #@jeu.position(@fenetre.position()) # => Jeu contient la position de la fenêtre [x, y]
    @fenetre.cacher()
    @jeu.ajouterEvenement(events)
  end
end