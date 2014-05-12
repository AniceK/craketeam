# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreChoixGrille < Fenetre
  
  @texteChoixGrille
  @boutonToutesGrilles
  @boutonGrillesPerso
  @boutonGrilleAleatoire
  @boutonPrecedent
  
  attr_reader :texteChoixGrille,
              :boutonToutesGrilles,
              :boutonGrillesPerso,
              :boutonGrilleAleatoire,
              :boutonPrecedent
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Choix de grille")
    
    @texteChoixGrille = Gtk::Label.new("Veuillez choisir une grille créée ou aléatoire")
    @boutonToutesGrilles = Gtk::Button.new("Toutes les grilles")
    @boutonGrillesPerso = Gtk::Button.new("Grilles perso")
    @boutonGrilleAleatoire = Gtk::Button.new("Grille aléatoire")
    @boutonPrecedent = Gtk::Button.new("Précédent")
    
    @boutonToutesGrilles.set_size_request(120, 30)
    @boutonGrillesPerso.set_size_request(120, 30)
    @boutonGrilleAleatoire.set_size_request(120, 30)
    @boutonPrecedent.set_size_request(-1, 50)
    
    hBoxBoutons = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)

    hBoxBoutons.set_border_width(5)
    vBox.set_border_width(5)
    
    hBoxBoutons.pack_start(@boutonToutesGrilles, false, false, 0)
    hBoxBoutons.pack_start(@boutonGrillesPerso, false, false, 0)
    hBoxBoutons.pack_start(@boutonGrilleAleatoire, false, false, 0)
    
    vBox.pack_start(@texteChoixGrille, false, false, 30)
    vBox.pack_start(hBoxBoutons, false, false, 20)
    vBox.pack_start(@boutonPrecedent, false, false, 20)
    
    @fenetre.add(vBox)
  end
  
  def affichageVisiteur
    
    @boutonGrillesPerso.hide_all()
  end
  
end











