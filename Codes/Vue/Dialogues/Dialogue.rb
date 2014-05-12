# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

class Dialogue
  
  @popup
  @messageCentre
  
  attr_reader :popup,
              :messageCentre
  
  private_class_method :new
  
  def initialize(fenetreParent, largeur, hauteur, titre, message)
    
    @popup = Gtk::Dialog.new(titre, $main_application_window, Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT)           
    
    
    
    self.descendDe(fenetreParent)
    @popup.set_size_request(largeur, hauteur)
    @popup.set_resizable(false)
    
    @messageCentre = Gtk::Label.new(message)
    @messageCentre.set_justify(Gtk::JUSTIFY_CENTER)
  end
  
  def descendDe(fenetreParent)
    
    @popup.set_transient_for(fenetreParent)
  end
  
end














