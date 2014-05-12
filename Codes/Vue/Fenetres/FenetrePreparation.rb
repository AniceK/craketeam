# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetrePreparation < Fenetre
  
  @texteChoixTaille
  @texteChoixDifficulte
  
  @choix5x5
  @choix10x10
  @choix15x15
  @choix20x20
  @choix25x25
  
  @choixFacile
  @choixMoyen
  @choixDifficile
  
  @boutonPrecedent
  @boutonSuivant
  
  attr_reader :texteChoixTaille,
              :texteChoixDifficulte,
              :choix5x5,
              :choix10x10,
              :choix15x15,
              :choix20x20,
              :choix25x25,
              :choixFacile,
              :choixMoyen,
              :choixDifficile,
              :boutonPrecedent,
              :boutonSuivant
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Préparation de la partie")
    
    @texteChoixTaille = Gtk::Label.new("Veuillez sélectionner une taille de grille")
    @texteChoixDifficulte = Gtk::Label.new("Veuillez sélectionner une difficulté d'aide")
    
    @choix5x5 = Gtk::RadioButton.new("5x5")
    @choix10x10 = Gtk::RadioButton.new(@choix5x5, "10x10")
    @choix15x15 = Gtk::RadioButton.new(@choix5x5, "15x15")
    @choix20x20 = Gtk::RadioButton.new(@choix5x5, "20x20")
    @choix25x25 = Gtk::RadioButton.new(@choix5x5, "25x25")
    
    @choixFacile = Gtk::RadioButton.new("Facile")
    @choixMoyen = Gtk::RadioButton.new(@choixFacile, "Moyen")
    @choixDifficile = Gtk::RadioButton.new(@choixFacile, "Difficile")
    
    @boutonPrecedent = Gtk::Button.new("Précédent")
    @boutonSuivant = Gtk::Button.new("Suivant")
    
    @boutonPrecedent.set_size_request(-1, 50)
    
    hBoxBoutonsTaille = Gtk::HBox.new(true, 0)
    hBoxBoutonsDifficulte = Gtk::HBox.new(true, 0)
    hBoxBoutonsNavigation = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)

    hBoxBoutonsTaille.set_border_width(5)
    hBoxBoutonsDifficulte.set_border_width(5)
    hBoxBoutonsNavigation.set_border_width(5)
    vBox.set_border_width(5)
    
    hBoxBoutonsTaille.pack_start(@choix5x5, false, false, 0)
    hBoxBoutonsTaille.pack_start(@choix10x10, false, false, 0)
    hBoxBoutonsTaille.pack_start(@choix15x15, false, false, 0)
    hBoxBoutonsTaille.pack_start(@choix20x20, false, false, 0)
    hBoxBoutonsTaille.pack_start(@choix25x25, false, false, 0)
    
    hBoxBoutonsDifficulte.pack_start(@choixFacile, false, false, 0)
    hBoxBoutonsDifficulte.pack_start(@choixMoyen, false, false, 0)
    hBoxBoutonsDifficulte.pack_start(@choixDifficile, false, false, 0)
    
    hBoxBoutonsNavigation.pack_start(@boutonPrecedent, false, true, 0)
    hBoxBoutonsNavigation.pack_start(@boutonSuivant, false, true, 0)
    
    vBox.pack_start(@texteChoixTaille, true, true, 5)
    vBox.pack_start(hBoxBoutonsTaille, true, true, 10)
    
    vBox.pack_start(Gtk::HSeparator.new(), true, true, 0)
    
    vBox.pack_start(@texteChoixDifficulte, true, true, 5)
    vBox.pack_start(hBoxBoutonsDifficulte, true, true, 10)
    
    vBox.pack_start(hBoxBoutonsNavigation, false, true, 0)
    
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
  
  def choixDifficulte()
    
    @choixFacile.group().each{ |boutonTaille|
      if boutonTaille.active?() then
        if boutonTaille.label() == "Facile" then return 1
        elsif boutonTaille.label() == "Moyen" then return 2
        elsif boutonTaille.label() == "Difficile" then return 3
        end
      end
    }
  end
  
end











