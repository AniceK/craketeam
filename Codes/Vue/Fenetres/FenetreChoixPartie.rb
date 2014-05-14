# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreChoixPartie < Fenetre
  
  @texteChoixPartie
  @boutonChoisirSauvegarde
  @boutonPartie
  @boutonPrecedent
  @textePasDeSauvegardes
  
  attr_reader :texteChoixPartie,
              :boutonChoisirSauvegarde,
              :boutonNouvellePartie,
              :boutonPrecedent,
              :textePasDeSauvegardes
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Choix de partie")
    
    @texteChoixPartie = Gtk::Label.new("Voulez-vous continuer une partie ou en commencer une nouvelle ?")
    @boutonChoisirSauvegarde = Gtk::Button.new("Choisir une Sauvegarde")
    @boutonNouvellePartie = Gtk::Button.new("Nouvelle Partie")
    @boutonPrecedent = Gtk::Button.new("Précédent")
    
    @textePasDeSauvegarde = Gtk::Label.new.set_markup("<span foreground='red'>Aucune sauvegarde enregistrée</span>")
    
    @boutonChoisirSauvegarde.set_size_request(200, 50)
    @boutonNouvellePartie.set_size_request(200, 50)
    @boutonPrecedent.set_size_request(-1, 50)
    
    hBoxBoutons = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)

    hBoxBoutons.set_border_width(5)
    vBox.set_border_width(5)
    
    hBoxBoutons.pack_start(@boutonChoisirSauvegarde, false, false, 0)
    hBoxBoutons.pack_start(@boutonNouvellePartie, false, false, 0)
    
    vBox.pack_start(@texteChoixPartie, false, false, 30)
    vBox.pack_start(hBoxBoutons, false, false, 10)
    vBox.pack_start(@textePasDeSauvegarde, false, false, 3)
    vBox.pack_end(@boutonPrecedent, false, false, 0)
    
    @fenetre.add(vBox)
  end
  
  
  def affichageDepart()
    
    @textePasDeSauvegarde.hide_all()
  end
  
  def affichagePasDeSauvegarde()
    
    @textePasDeSauvegarde.show_all()
  end
  
end











