# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreProfil < Fenetre
  
  @texteNomProfil
  @entreeNomProfil
  @boutonCreerProfil
  @boutonChargerProfil
  @boutonPrecedent
  
  attr_reader :texteNomProfil, :entreeNomProfil, :boutonCreerProfil, :boutonChargerProfil, :boutonPrecedent
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Profil")
    
    @texteNomProfil = Gtk::Label.new("Nom de profil :")
    @entreeNomProfil = Gtk::Entry.new()
    @boutonCreerProfil = Gtk::Button.new("Créer Profil")
    @boutonChargerProfil = Gtk::Button.new("Charger Profil")
    @boutonPrecedent = Gtk::Button.new('Précédent')
    @textePseudoExistant = Gtk::Label.new("")
    @textePseudoInexistant = Gtk::Label.new("")
    
    @entreeNomProfil.set_max_length(20)
    @entreeNomProfil.set_text("player")
    @boutonCreerProfil.set_size_request(150, 50)
    @boutonChargerProfil.set_size_request(150, 50)
    @boutonPrecedent.set_size_request(-1, 50)
    
    hBoxNom = Gtk::HBox.new(true, 0)
    hBoxBoutons = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)
    
    hBoxNom.set_border_width(5)
    hBoxBoutons.set_border_width(5)
    vBox.set_border_width(5)
    
    hBoxNom.pack_start(@texteNomProfil, false, false, 0)
    hBoxNom.pack_start(@entreeNomProfil, false, false, 0)
    
    hBoxBoutons.pack_start(@boutonCreerProfil, false, false, 0)
    hBoxBoutons.pack_start(@boutonChargerProfil, false, false, 0)
    
    vBox.pack_start(hBoxNom, true, true, 10)
    vBox.pack_start(@textePseudoExistant, true, true, 10)
    vBox.pack_start(@textePseudoInexistant, true, true, 10)
    vBox.pack_start(hBoxBoutons, false, true, 20)
    vBox.pack_start(@boutonPrecedent, false, true, 0)
    
    @fenetre.add(vBox)
  end
  
  def affichageDepart
    
    @textePseudoExistant.hide_all()
    @textePseudoInexistant.hide_all()
  end
  
  def affichagePseudoExistant
    
    @textePseudoInexistant.hide_all()
    @textePseudoExistant.set_markup("<span foreground='red'>Le pseudo \"" + @entreeNomProfil.text() + "\" est déjà utilisé</span>")
    @textePseudoExistant.show_all()
  end
  
  def affichagePseudoInexistant
    
    @textePseudoExistant.hide_all()
    @textePseudoInexistant.set_markup("<span foreground='red'>Le pseudo \"" + @entreeNomProfil.text() + "\" n'existe pas</span>")
    @textePseudoInexistant.show_all()
  end
  
end











