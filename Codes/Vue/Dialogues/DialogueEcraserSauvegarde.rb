# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Dialogue'

class DialogueEcraserSauvegarde < Dialogue
  
  @doitEcraser
  
  attr_reader :doitEcraser
  
  public_class_method :new
  
  def initialize(fenetreParent)
    
    super(fenetreParent, 350, 120,
          "Ecraser sauvegarde ?",
          "Une sauvegarde possède déjà ce nom.\nVoulez-vous la remplacer ?")
    
    @popup.vbox.add(@messageCentre)
    
    @popup.add_button(Gtk::Stock::YES, Gtk::Dialog::RESPONSE_ACCEPT)
    @popup.add_button(Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT)
    
    @popup.default_response = Gtk::Dialog::RESPONSE_REJECT
    
    @popup.vbox.show_all()
      
    @popup.run do |response|
      case response
        when Gtk::Dialog::RESPONSE_ACCEPT
          
          @doitEcraser = true
          
        else                                      
          
          @doitEcraser = false
      end
      
      @popup.destroy
    end
  end

end














