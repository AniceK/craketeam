# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Dialogue'

class DialogueQuitterEditeur < Dialogue
  
  @doitArreterEditeur
  
  attr_reader :doitArreterEditeur
  
  public_class_method :new
  
  def initialize(fenetreParent)
    
    super(fenetreParent, 380, 120,
          "Quitter éditeur ?",
          "Êtes-vous sûr de vouloir quitter la création en cours ?\n
          Votre grille ne sera pas sauvegardée.")
          
    @popup.vbox.add(@messageCentre)
    
    @popup.add_button(Gtk::Stock::YES, Gtk::Dialog::RESPONSE_ACCEPT)
    @popup.add_button(Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT)
    
    @popup.default_response = Gtk::Dialog::RESPONSE_REJECT
    
    @popup.vbox.show_all()
      
    @popup.run do |response|
      case response
        when Gtk::Dialog::RESPONSE_ACCEPT
          
          @doitArreterEditeur = true
          
        else                                      
          
          @doitArreterEditeur = false
      end
      
      @popup.destroy
    end
  end

end














