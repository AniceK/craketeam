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
  
  attr_reader :jeu,
              :fenetre
  
  private_class_method :new
  
# On transmet les données du jeu entre les évènements
  def initialize(jeu, position)
    
    @jeu = jeu
    
    if position != Gtk::Window::POS_CENTER then
      
      self.bouger(position)
      
    else
      
      @fenetre.widget.set_window_position(Gtk::Window::POS_CENTER)
      
    end
    
    
    if @jeu.profilConnecte?() then
      
      pseudoTitre = jeu.profil.nom
      
    elsif !@jeu.profilConnecte?() then
      
      pseudoTitre = "Visiteur"
      
    else
      
      puts "Erreur: Problème de détection du profil"
      
    end
    
    @fenetre.titre(pseudoTitre)
    
  end

# On change l'évènement à prendre en compte dans le jeu lors d'un changement de fenêtre
  def mouvement(events)
    
    @fenetre.cacher()
    @jeu.ajouterEvenement(events)
  end
  
  def position()
    
    return @fenetre.position()
  end
  
  def bouger(position)
    
    @fenetre.move(position[0], position[1])
  end
  
end

















