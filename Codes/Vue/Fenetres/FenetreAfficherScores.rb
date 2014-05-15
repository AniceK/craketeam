# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'
require './Vue/Elements/ListeElements'

class FenetreAfficherScores < Fenetre
  
  @texteAfficherScores
  @boutonPrecedent
  @listeScores
  
  
  attr_reader :boutonPrecedent,
              :texteAfficherScores,
              :listeScores
  
  public_class_method :new
  
  def initialize(listeScores)
    super()
    
    @fenetre.set_title("High Score")
    
    #==================================================#
    #           Déclaration / Initialisation           #
    #==================================================#
    
    @texteAfficherScores = Gtk::Label.new("Voici les meilleurs joueurs de Picross")
    
    @boutonPrecedent = Gtk::Button.new('Précédent')
    
    @listeScores = ListeElements.new(listeScores, true)
    
    #==================================================#
    #               Paramètrage éléments               #
    #==================================================#
    
    @boutonPrecedent.set_size_request(-1, 50)
    
    #==================================================#
    #                  Déclaration Box                 #
    #==================================================#
    
    vBox = Gtk::VBox.new(false, 0)
    
    #==================================================#
    #                 Paramètrage Box                  #
    #==================================================#
    
    vBox.set_border_width(5)
    
    #==================================================#
    #                  Remplissage Box                 #
    #==================================================#
    
    
    vBox.pack_start(@texteAfficherScores, false, false, 5)
    vBox.pack_start(@listeScores.widget(), true, true, 5)
    vBox.pack_end(@boutonPrecedent, false, true, 0)
    
    #==================================================#
    #                Ajout à la fenêtre                #
    #==================================================#
    
    @fenetre.add(vBox)
  end
  
end











