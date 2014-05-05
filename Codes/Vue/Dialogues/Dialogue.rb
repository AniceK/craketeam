# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

class Dialogue
  
  @popup
  
  attr_reader :popup
  
  private_class_method :new
  
  def initialize(message)
    
    @popup = Gtk::Dialog.new(message, $main_application_window, Gtk::Dialog::DESTROY_WITH_PARENT)           
                         
    @popup.set_window_position(Gtk::Window::POS_CENTER)
    @popup.set_size_request(300, 100)
    @popup.set_resizable(false)
                              
    @popup.add_button(Gtk::Stock::YES, Gtk::Dialog::RESPONSE_ACCEPT)
    @popup.add_button(Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT)
  end
  
end














