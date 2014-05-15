# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Dialogue'

class DialogueReinitialiser < Dialogue
  
  @doitReinitialiser
  
  attr_reader :doitReinitialiser
  
  public_class_method :new
  
  def initialize(fenetreParent)
    
    super(fenetreParent, 350, 120,
          "Reinitialiser ?",
          "Êtes-vous sûr de vouloir réinitialiser ?
          Toute supression sera définitive.")
    
    @popup.vbox.add(@messageCentre)
    
    @popup.add_button(Gtk::Stock::YES, Gtk::Dialog::RESPONSE_ACCEPT)
    @popup.add_button(Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT)
    
    @popup.default_response = Gtk::Dialog::RESPONSE_REJECT
    
    @popup.vbox.show_all()
      
    @popup.run do |response|
      case response
        when Gtk::Dialog::RESPONSE_ACCEPT
          
          @doitReinitialiser = true
          
        else                                      
          
          @doitReinitialiser = false
      end
      
      @popup.destroy
    end
  end

end














