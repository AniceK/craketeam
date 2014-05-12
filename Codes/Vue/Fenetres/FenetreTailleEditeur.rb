# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreTailleEditeur < Fenetre
  
  @texteChoixTaille
  
  @choix5x5
  @choix10x10
  @choix15x15
  @choix20x20
  @choix25x25
  
  @boutonPrecedent
  @boutonSuivant
  
  attr_reader :texteChoixTaille,
              :choix5x5,
              :choix10x10,
              :choix15x15,
              :choix20x20,
              :choix25x25,
              :boutonPrecedent,
              :boutonSuivant
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Taille de l'éditeur")
    
    @texteChoixTaille = Gtk::Label.new("Veuillez sélectionner une taille de grille")
    
    @choix5x5 = Gtk::RadioButton.new("5x5")
    @choix10x10 = Gtk::RadioButton.new(@choix5x5, "10x10")
    @choix15x15 = Gtk::RadioButton.new(@choix5x5, "15x15")
    @choix20x20 = Gtk::RadioButton.new(@choix5x5, "20x20")
    @choix25x25 = Gtk::RadioButton.new(@choix5x5, "25x25")
    
    @boutonPrecedent = Gtk::Button.new("Précédent")
    @boutonSuivant = Gtk::Button.new("Suivant")
    
    @boutonPrecedent.set_size_request(-1, 50)
    
    hBoxBoutonsTaille = Gtk::HBox.new(true, 0)
    hBoxBoutonsNavigation = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)

    hBoxBoutonsTaille.set_border_width(5)
    hBoxBoutonsNavigation.set_border_width(5)
    vBox.set_border_width(5)
    
    hBoxBoutonsTaille.pack_start(@choix5x5, false, false, 0)
    hBoxBoutonsTaille.pack_start(@choix10x10, false, false, 0)
    hBoxBoutonsTaille.pack_start(@choix15x15, false, false, 0)
    hBoxBoutonsTaille.pack_start(@choix20x20, false, false, 0)
    hBoxBoutonsTaille.pack_start(@choix25x25, false, false, 0)
    
    hBoxBoutonsNavigation.pack_start(@boutonPrecedent, false, true, 0)
    hBoxBoutonsNavigation.pack_start(@boutonSuivant, false, true, 0)
    
    vBox.pack_start(@texteChoixTaille, false, false, 30)
    vBox.pack_start(hBoxBoutonsTaille, false, false, 10)
    
    vBox.pack_end(hBoxBoutonsNavigation, false, true, 0)
    
    @fenetre.add(vBox)
  end
  
  def choixTaille()
    
    @choix5x5.group().each{ |boutonTaille|
      if boutonTaille.active?() then
        if boutonTaille.label() == "5x5" then return 5
        elsif boutonTaille.label() == "10x10" then return 10
        elsif boutonTaille.label() == "15x15" then return 15
        elsif boutonTaille.label() == "20x20" then return 20
        elsif boutonTaille.label() == "25x25" then return 25
        end
      end
    }
  end
  
end











