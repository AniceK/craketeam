# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Dialogue'

class DialogueAide < Dialogue
  
  @doitArreterPartie
  
  attr_reader :doitArreterPartie
  
  public_class_method :new
  
  def initialize(fenetreParent, message)
    
    super(fenetreParent, 380, 250, "Aide", message)
    
    @popup.resize(380, 350)
             
    @popup.add_button(Gtk::Stock::OK, Gtk::Dialog::RESPONSE_ACCEPT)
    
    @popup.default_response = Gtk::Dialog::RESPONSE_ACCEPT
    
    @messageCentre.set_wrap(true)
    
    scrollMessage = Gtk::ScrolledWindow.new()
    scrollMessage.border_width = 5
    scrollMessage.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
    scrollMessage.add_with_viewport(@messageCentre)
    
    @popup.vbox.add(scrollMessage)
    
    @popup.vbox.show_all()
      
    @popup.run do |response|
      case response
        when Gtk::Dialog::RESPONSE_ACCEPT
          puts "Ok cliqué"        
      end
      
      @popup.destroy
    end
  end

end














