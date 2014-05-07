# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Dialogue'

class DialogueQuitter < Dialogue
  
  @doitQuitter
  
  attr_reader :doitQuitter
  
  public_class_method :new
  
  def initialize()
    
    super("Quitter ?")
    
    @popup.default_response = Gtk::Dialog::RESPONSE_REJECT
    
    @popup.vbox.add(Gtk::Label.new("Êtes-vous sûr de vouloir quitter ?"))
    
    @popup.vbox.show_all()
      
    @popup.run do |response|
      case response
        when Gtk::Dialog::RESPONSE_ACCEPT
          puts "Validation fermeture application !"
          @doitQuitter = true
        else                                      
          puts "Annulation fermeture application !"
          @doitQuitter = false
      end
      
      @popup.destroy
    end
  end
  
  def doitQuitter()
    return @doitQuitter
  end

end














