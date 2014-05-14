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
    @texteAucuneGrille = Gtk::Label.new.set_markup("<span foreground='red'>Il n'y a aucune grille de disponible\nMais vous pouvez en créer une dans l'éditeur avec un profil !</span>")
    @texteAucuneGrillePerso = Gtk::Label.new.set_markup("<span foreground='red'>Vous n'avez aucune grille perso\nMais vous pouvez en créer une dans l'éditeur !</span>")
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
    
    vBox.pack_start(@texteChoixGrille, false, false, 20)
    vBox.pack_start(hBoxBoutons, false, false, 20)
    vBox.pack_start(@texteAucuneGrille, false, false, 0)
    vBox.pack_start(@texteAucuneGrillePerso, false, false, 0)
    vBox.pack_end(@boutonPrecedent, false, false, 0)
    
    @fenetre.add(vBox)
  end
  
  def affichageVisiteur
    
    @boutonGrillesPerso.hide_all()
  end
  
  def affichageDepart()
    
    @texteAucuneGrille.hide_all()
    @texteAucuneGrillePerso.hide_all()
  end
  
  def affichageAucuneGrille
    
    @texteAucuneGrillePerso.hide_all()
    @texteAucuneGrille.show_all()
  end
  
  def affichageAucuneGrillePerso
    
    @texteAucuneGrille.hide_all()
    @texteAucuneGrillePerso.show_all()
  end
  
end











