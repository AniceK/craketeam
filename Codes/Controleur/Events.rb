# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require './Moteur/Profil.rb'

class Events
  
  @jeu
  @fenetre
  @eventsCourants
  
  private_class_method :new
  
  def initialize(jeu)
    @jeu = jeu
  end
  
  def mouvement(events)
    
    @fenetre.cacher()
    @jeu.evenements = events
  end
end