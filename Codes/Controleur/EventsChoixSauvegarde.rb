# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require './Vue/Fenetres/FenetreChoixSauvegarde'

#################### À supprimer par la suite #########################
                                                                      #
class GroceryItem                                                     #
  attr_accessor :taille, :nom, :date                                  #
  def initialize(t, n, d); @taille, @nom, @date = t, n, d; end        #
end                                                                   #
                                                                      #
#######################################################################

class EventsChoixSauvegarde < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    #listeSauvegardes = @jeu.listeSauvegardes() # => Renvoie un tableau de grilles ayant des variables "taille", "nom", "date"
    
    ################# À supprimer par la suite ########################################
                                                                                      #
    listeSauvegardes = Array.new                                                      #
    listeSauvegardes[0] = GroceryItem.new(5,  "ma_grille_5", "01/03/14")              #
    listeSauvegardes[1] = GroceryItem.new(5,  "ma_grille_mal_barree", "02/03/14")     #
    listeSauvegardes[2] = GroceryItem.new(10, "ma_grille_10", "03/03/14")             #
    listeSauvegardes[3] = GroceryItem.new(15,  "ma_grille_15", "04/03/14")            #
    listeSauvegardes[4] = GroceryItem.new(20, "ma_grille_20", "05/03/14")             #
    listeSauvegardes[5] = GroceryItem.new(25,  "ma_grille_25", "06/03/14")            #
                                                                                      #
    ###################################################################################
    
    @fenetre = FenetreChoixSauvegarde.new(listeSauvegardes)
    @fenetre.afficher()
    
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      
      puts "> Choix Partie"
      mouvement(EventsChoixPartie.new(@jeu))
    }
    
    @fenetre.boutonSuivant.signal_connect('clicked'){
      
      #sauvegarde = @fenetre.choixSauvegarde()
      
      #puts "> Suivant (Sauvegarde: " + sauvegarde + ")"
      
      #@jeu.chargerPartie(sauvegarde)
      
      #mouvement(EventsJeu.new(@jeu))
    }
  end
  
end