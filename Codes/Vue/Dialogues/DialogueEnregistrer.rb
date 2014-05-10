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
  @nomSauvegarde
  
  attr_reader :doitSauvegarderEtQuitter,
              :nomSauvegarde
  
  public_class_method :new
  
  def initialize()
    
    super("Sauvegarder et quitter ?",
    
          "Veuillez entrer un nom pour votre création :")
  
    @popup.add_button("Sauvegarder et Quitter", Gtk::Dialog::RESPONSE_ACCEPT)
    @popup.add_button(Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT)
    
    @popup.default_response = Gtk::Dialog::RESPONSE_REJECT
    
    entreeNomSauvegarde = Gtk::Entry.new()
    entreeNomSauvegarde.set_max_length(20)
    entreeNomSauvegarde.set_text("creation_")
    entreeNomSauvegarde.set_xalign(0.5)
    
    @popup.vbox.add(entreeNomSauvegarde)
    
    @popup.vbox.show_all()
      
    @popup.run do |response|
      
      case response
        
        when Gtk::Dialog::RESPONSE_ACCEPT
          
          @nomSauvegarde = entreeNomSauvegarde.text()
          @doitSauvegarderEtQuitter = true
          
        else                                      
          
          @doitSauvegarderEtQuitter = false
      end
      
      @popup.destroy
    end
  end
end














