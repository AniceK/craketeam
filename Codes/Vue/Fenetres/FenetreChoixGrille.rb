# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require './Vue/Fenetres/Fenetre.rb'

class FenetreChoixGrille < Fenetre
  
  @texteChoixGrille
  @boutonGrilleCreee
  @boutonGrilleAleatoire
  @boutonPrecedent
  
  attr_reader :texteChoixGrille, :boutonGrilleCreee, :boutonGrilleAleatoire, :boutonPrecedent
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Choix de grille")
    
    @texteChoixGrille = Gtk::Label.new("Veuillez choisir une grille créée ou aléatoire")
    @boutonGrilleCreee = Gtk::Button.new("Grille créée")
    @boutonGrilleAleatoire = Gtk::Button.new("Grille aléatoire")
    @boutonPrecedent = Gtk::Button.new("Précédent")
    
    @boutonGrilleCreee.set_size_request(100, 30)
    @boutonGrilleAleatoire.set_size_request(100, 30)
    @boutonPrecedent.set_size_request(-1, 50)
    
    hBoxBoutons = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)

    hBoxBoutons.set_border_width(5)
    vBox.set_border_width(5)
    
    hBoxBoutons.pack_start(@boutonGrilleCreee, false, false, 0)
    hBoxBoutons.pack_start(@boutonGrilleAleatoire, false, false, 0)
    
    vBox.pack_start(@texteChoixGrille, false, false, 10)
    vBox.pack_start(hBoxBoutons, false, false, 10)
    vBox.pack_start(@boutonPrecedent, false, false, 10)
    
    @fenetre.add(vBox)
  end
  
end











