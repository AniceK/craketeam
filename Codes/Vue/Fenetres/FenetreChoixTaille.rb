# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require './Vue/Fenetres/Fenetre.rb'

class FenetreChoixTaille < Fenetre
  
  @texteChoixTaille
  @bouton5x5
  @bouton10x10
  @bouton15x15
  @bouton20x20
  @bouton25x25
  @boutonPrecedent
  
  attr_reader :texteChoixTaille, :bouton5x5, :bouton10x10, :bouton15x15, :bouton20x20, :bouton25x25, :boutonPrecedent
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Taille de grille")
    
    @texteChoixTaille = Gtk::Label.new("Veuillez sélectionner une taille de grille")
    @bouton5x5 = Gtk::Button.new("5x5")
    @bouton10x10 = Gtk::Button.new("10x10")
    @bouton15x15 = Gtk::Button.new("15x15")
    @bouton20x20 = Gtk::Button.new("20x20")
    @bouton25x25 = Gtk::Button.new("25x25")
    @boutonPrecedent = Gtk::Button.new("Précédent")
    
    @bouton5x5.set_size_request(70, 30)
    @bouton10x10.set_size_request(70, 30)
    @bouton15x15.set_size_request(70, 30)
    @bouton20x20.set_size_request(70, 30)
    @bouton25x25.set_size_request(70, 30)
    @boutonPrecedent.set_size_request(-1, 50)
    
    hBoxBoutons = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)

    hBoxBoutons.set_border_width(5)
    vBox.set_border_width(5)
    
    hBoxBoutons.pack_start(@bouton5x5, false, false, 0)
    hBoxBoutons.pack_start(@bouton10x10, false, false, 0)
    hBoxBoutons.pack_start(@bouton15x15, false, false, 0)
    hBoxBoutons.pack_start(@bouton20x20, false, false, 0)
    hBoxBoutons.pack_start(@bouton25x25, false, false, 0)
    
    vBox.pack_start(@texteChoixTaille, false, false, 30)
    vBox.pack_start(hBoxBoutons, false, false, 20)
    vBox.pack_start(@boutonPrecedent, false, false, 20)
    
    @fenetre.add(vBox)
  end
  
end











