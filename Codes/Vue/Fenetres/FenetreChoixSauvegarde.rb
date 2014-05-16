# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'
require './Vue/Elements/ListeElements'

#===============================================================================#
#                                                                               #
#   La classe FenetreChoixSauvegarde n'est pas instantiable est instantiable    #
#    Elle permet de créer une fenêtre qui permettra de choisir une sauvegarde   #
#                                                                               #
#===============================================================================#

class FenetreChoixSauvegarde < Fenetre
  
  @texteChoixSauvegarde
  # Texte "Choisissez votre sauvegarde"
  @boutonPrecedent
  
  @boutonSupprimer
  @boutonSuivant
  @listeSauvegarde
  
  
  attr_reader :boutonPrecedent,
              :boutonSupprimer,
              :boutonSuivant,
              :texteChoixSauvegarde,
              :listeSauvegarde
  
  public_class_method :new
  
  def initialize(listeSauvegardes)
    super()
    
    @fenetre.set_title("ChoixSauvegarde")
    
    #==================================================#
    #           Déclaration / Initialisation           #
    #==================================================#
    
    @texteChoixSauvegarde = Gtk::Label.new("Choisissez votre sauvegarde")
    
    @boutonPrecedent = Gtk::Button.new('Précédent')
    @boutonSupprimer = Gtk::Button.new('Supprimer')
    @boutonSuivant = Gtk::Button.new('Suivant')
    
    @listeSauvegardes = ListeElements.new(listeSauvegardes, false)
    
    #==================================================#
    #               Paramètrage éléments               #
    #==================================================#
    
    @boutonPrecedent.set_size_request(-1, 50)
    @boutonSupprimer.set_size_request(-1, 50)
    @boutonSuivant.set_size_request(-1, 50)
    
    #==================================================#
    #                  Déclaration Box                 #
    #==================================================#
    
    hBoxNavigation = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)
    
    #==================================================#
    #                 Paramètrage Box                  #
    #==================================================#
    
    vBox.set_border_width(5)
    hBoxNavigation.set_border_width(5)
    
    #==================================================#
    #                  Remplissage Box                 #
    #==================================================#
    
    hBoxNavigation.pack_start(@boutonPrecedent, true, true, 5)
    #hBoxNavigation.pack_start(@boutonSupprimer, true, true, 5)
    hBoxNavigation.pack_start(@boutonSuivant, true, true, 5)
    
    vBox.pack_start(@texteChoixSauvegarde, false, false, 5)
    vBox.pack_start(@listeSauvegardes.widget(), true, true, 5)
    vBox.pack_end(hBoxNavigation, false, true, 0)
    
    #==================================================#
    #                Ajout à la fenêtre                #
    #==================================================#
    
    @fenetre.add(vBox)
  end
  
  def choixSauvegarde()
    
    return @listeSauvegardes.selectionCourante()
  end
  
end











