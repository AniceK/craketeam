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
    
    # Permet de centrer la redimension d'une fenêtre sur son centre
    @fenetreHints.set_win_gravity(Gdk::Window::GRAVITY_CENTER)
    
    @fenetre.set_geometry_hints(@fenetre,
                                @fenetreHints,
                                Gdk::Window::HINT_WIN_GRAVITY)
    
    self.redimensionner(500, 250)

    @fenetre.signal_connect('destroy') {fermeture}
  end
  
  def widget()
    
    return @fenetre
  end
  
  def position()
    
    return @fenetre.position()
  end
  
  def move(x, y)
    
    return @fenetre.move(x, y)
  end
  
  def afficher()
    
    @fenetre.show_all()
  end
  
  def cacher()
    
    @fenetre.hide_all()
  end
  
  def redimensionner(x, y)
    
    #  if @fenetre.gravity() == Gdk::Window::GRAVITY_CENTER then
    #    puts "GRAVITY_CENTER !"
    #  else
    #    puts "Pas Center..."
    #  end
    
    # Fixation largeur
    @fenetreHints.set_min_width(x)
    @fenetreHints.set_max_width(x)
    
    # Fixation hauteur
    @fenetreHints.set_min_height(y)
    @fenetreHints.set_max_height(y)
    
    @fenetre.set_geometry_hints(@fenetre,
                                @fenetreHints,
                                Gdk::Window::HINT_MIN_SIZE |
                                Gdk::Window::HINT_MAX_SIZE)
  end
  
  def titre(pseudo)
    
    @fenetre.set_title( @fenetre.title() + " - " + pseudo )
  end
  
  ### Fin de l'exécution ###
  def fermeture()
        
    puts "Fermeture fenêtre !"
    quitter()
  end
  
  def quitter()
    
    puts "Quitte GUI"
    Gtk.main_quit
  end
  
end














