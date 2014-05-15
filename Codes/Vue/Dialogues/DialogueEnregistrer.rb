# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Dialogue'

class DialogueEnregistrer < Dialogue
  
  @doitSauvegarderEtQuitter
  @entreeNomSauvegarde
  @labelNomExistant
  
  attr_reader :doitSauvegarderEtQuitter,
              :entreeNomSauvegarde,
              :labelNomExistant
  
  public_class_method :new
  
  def initialize(fenetreParent)
    
    super(fenetreParent, 380, 140,
          "Sauvegarder et quitter ?",
          "Veuillez entrer un nom pour votre grille :")
  
    @popup.add_button("Sauvegarder et Quitter", Gtk::Dialog::RESPONSE_ACCEPT)
    @popup.add_button(Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT)
    
    @popup.default_response = Gtk::Dialog::RESPONSE_REJECT
    
    @entreeNomSauvegarde = Gtk::Entry.new()
    @entreeNomSauvegarde.set_max_length(20)
    @entreeNomSauvegarde.set_text("ma_grille")
    @entreeNomSauvegarde.set_xalign(0.5)
    
    @labelNomExistant = Gtk::Label.new("")
    
    @popup.vbox.add(@messageCentre)
    @popup.vbox.add(@entreeNomSauvegarde)
    @popup.vbox.add(@labelNomExistant)
    
    @popup.vbox.show_all()
    
    @labelNomExistant.hide_all()
    
  end
  
  def nomExistant(nom)
    
    @labelNomExistant.set_markup("<span foreground='red'>Nom \"" + nom + "\" déjà utilisé</span>")
    @labelNomExistant.show_all()
  end
  
end














