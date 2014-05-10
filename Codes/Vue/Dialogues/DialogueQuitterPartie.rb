# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Dialogue'

class DialogueQuitterPartie < Dialogue
  
  @doitArreterPartie
  
  attr_reader :doitArreterPartie
  
  public_class_method :new
  
  def initialize()
    
    super("Arrêter partie ?",
    
          "Êtes-vous sûr de vouloir quitter la partie en cours ?\n
          Toute progression non sauvegardée sera perdue.")
    
    @popup.default_response = Gtk::Dialog::RESPONSE_REJECT
    
    @popup.vbox.show_all()
      
    @popup.run do |response|
      case response
        when Gtk::Dialog::RESPONSE_ACCEPT
          puts "> Accueil"
          @doitArreterPartie = true
        else                                      
          puts "> Jeu"
          @doitArreterPartie = false
      end
      
      @popup.destroy
    end
  end
  
  def doitArreterPartie()
    return @doitArreterPartie
  end

end














