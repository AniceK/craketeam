# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreAccueil < Fenetre
  
  @imageBanniere
  @boutonPartieRapide
  @boutonJouer
  @boutonProfil
  @boutonEditeur
  @boutonOptions
  @boutonCredits
  @boutonQuitter
  @boutonDeconnexion
  
  attr_reader :imageBanniere,
              :boutonPartieRapide,
              :boutonProfil,
              :boutonOptions,
              :boutonCredits,
              :boutonQuitter,
              :boutonJouer,
              :boutonEditeur,
              :boutonDeconnexion
              
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Accueil")
    
    @imageBanniere = Gtk::Image.new('../Vue/Images/banniere.jpg')
    
    @boutonPartieRapide = Gtk::Button.new('Partie Rapide')
    @boutonJouer = Gtk::Button.new('Jouer') # Avec profil
    @boutonProfil = Gtk::Button.new('Profil')
    @boutonEditeur = Gtk::Button.new('Editeur') # Avec profil
    @boutonOptions = Gtk::Button.new('Options')
    @boutonCredits = Gtk::Button.new('Credits')
    @boutonQuitter = Gtk::Button.new('Quitter')
    @boutonDeconnexion = Gtk::Button.new('Déconnexion Profil') # Avec profil
    
    vBox = Gtk::VBox.new(false, 0)
    vBox.set_border_width(5)
    
    vBox.pack_start(@imageBanniere, true, true, 0)
    vBox.pack_start(@boutonPartieRapide, true, true, 0)
    vBox.pack_start(@boutonJouer, true, true, 0) # Avec profil
    vBox.pack_start(@boutonProfil, true, true, 0)
    vBox.pack_start(@boutonEditeur, true, true, 0) # Avec profil
    vBox.pack_start(@boutonOptions, true, true, 0)
    vBox.pack_start(@boutonCredits, true, true, 0)
    vBox.pack_start(@boutonQuitter, true, true, 0)
    vBox.pack_start(@boutonDeconnexion, true, true, 0) # Avec profil
    
    @fenetre.add(vBox)
  end
  
  
  def affichageAvecProfil()
    
    @boutonPartieRapide.hide_all()
    @boutonProfil.hide_all()
    @boutonQuitter.hide_all()
  end
  
  def affichageSansProfil()
    
    @fenetre.set_title("Accueil - Visiteur")
    
    @boutonJouer.hide_all()
    @boutonEditeur.hide_all()
    @boutonDeconnexion.hide_all()
    
    @boutonPartieRapide.show_all()
    @boutonProfil.show_all()
    @boutonQuitter.show_all()
  end
  
end











