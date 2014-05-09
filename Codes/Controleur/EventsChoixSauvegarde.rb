# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require './Vue/Fenetres/FenetreChoixSauvegarde'

class EventsCredits < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreChoixSauvegarde.new()
    @fenetre.afficher()
    
    #@fenetre.bouton.signal_connect('clicked'){
    #  puts "> "
    #  
    #  mouvement(Events.new(jeu))
    #}
  end
  
end