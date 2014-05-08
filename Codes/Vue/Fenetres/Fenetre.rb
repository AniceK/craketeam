# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

class Fenetre
  
  @fenetre
  @fenetreHints
  
  attr_reader :fenetre
  
  private_class_method :new
  
  def initialize()
    
    @fenetre = Gtk::Window.new()
    
    @fenetreHints = Gdk::Geometry.new()
    
    redimensionner(500, 250)
    
    
    @fenetre.set_window_position(Gtk::Window::POS_CENTER)
    #@fenetre.set_default_size(500, 230)
    #@fenetre.set_size_request(500, 230)
    #@fenetre.set_resizable(false)
    @fenetre.signal_connect('destroy') {fermeture}
  end
  
  def afficher()
    
    @fenetre.show_all()
  end
  
  def cacher()
    
    @fenetre.hide_all()
  end
  
  def redimensionner(x, y)
    
    #@fenetre.resize(x, y)
    
    @fenetreHints.set_min_width(x)
    @fenetreHints.set_min_height(y)
    
    @fenetreHints.set_max_width(x)
    @fenetreHints.set_max_height(y)
    
    @fenetre.set_geometry_hints(@fenetre,
                                @fenetreHints,
                                Gdk::Window::HINT_MIN_SIZE |
                                Gdk::Window::HINT_MAX_SIZE)
  end
  
  ### Fin de l'exécution ###
  def fermeture     
        
    puts "Fermeture fenêtre !"
    quitter()
  end
  
  def quitter
    
    puts "Quitte GUI"
    Gtk.main_quit
  end
  
end














