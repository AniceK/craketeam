# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsChoixGrille'
require_relative 'EventsJeu'
require './Vue/Fenetres/FenetreChoixCreation'

###################### À supprimer par la suite #########################
#                                                                       #
# class GroceryItem                                                     #
#   attr_accessor :taille, :nom, :date                                  #
#   def initialize(t, n, d); @taille, @nom, @date = t, n, d; end        #
# end                                                                   #
#                                                                       #
#########################################################################

class EventsChoixCreation < Events
  
  public_class_method :new
  
  def initialize(jeu, afficheTout)
    
    super(jeu)
    
    tailleCreation = @jeu.tailleGrille()
    
    listeCreations = @jeu.chargerListeGrillesExistantes(tailleCreation, afficheTout) # => Renvoie un tableau de grilles ayant des variables "taille", "nom", "date"
    
    ################# À supprimer par la suite ########################################
    #                                                                                 #
    # listeCreations = Array.new                                                      #
    # listeCreations[0] = GroceryItem.new(5,  "ma_grille_5", "01/07/14")              #
    # listeCreations[1] = GroceryItem.new(5,  "ma_grille_mal_barree", "02/03/14")     #
    # listeCreations[2] = GroceryItem.new(10, "ma_grille_10", "03/03/15")             #
    # listeCreations[3] = GroceryItem.new(15,  "ma_grille_15", "04/04/14")            #
    # listeCreations[4] = GroceryItem.new(20, "ma_grille_20", "05/03/13")             #
    # listeCreations[5] = GroceryItem.new(25,  "ma_grille_25", "06/03/14")            #
    #                                                                                 #
    ###################################################################################
    
    @fenetre = FenetreChoixCreation.new(listeCreations)
    @fenetre.afficher()
    #@fenetre.move(@jeu.positionX(), @jeu.positionY()) # => @jeu.positionX() renvoie position[0] et Y -> position[1]
    
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      
      puts "> Choix Grille"
      mouvement(EventsChoixGrille.new(@jeu))
    }
    
    @fenetre.boutonSuivant.signal_connect('clicked'){
      
      nomCreation = @fenetre.choixCreation()
      
      puts "> Suivant (Creation: " + nomCreation + ")"
      
      @jeu.chargerGrille(nomCreation, tailleCreation)
      
      mouvement(EventsJeu.new(@jeu))
    }
  end
  
end