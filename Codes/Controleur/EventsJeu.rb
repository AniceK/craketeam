# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsPreparation'  # DEBUG
require './Vue/Fenetres/FenetreJeu'

class EventsJeu < Events
  
  @taille
  @imageCaseVide
  @imageCaseNoircie
  @imageCaseMarquee
  
  attr_reader :taille, :imageCaseVide, :imageCaseNoircie, :imageCaseMarquee
  
  public_class_method :new
  
  def initialize(jeu, tailleGrille)
    
    super(jeu)
    
    @taille = tailleGrille
    @imageCaseVide = Gtk::Image.new('./Vue/Images/vide.gif')
    @imageCaseNoircie = Gtk::Image.new('./Vue/Images/noircie.gif')
    @imageCaseMarquee = Gtk::Image.new('./Vue/Images/marquee.gif')
    
    # Mise en place de la grille et de ses conditions
    
    @fenetre = FenetreJeu.new()
    @fenetre.redimensionner(600 + (@taille*10), 350 + (@taille*10))
    @fenetre.afficher()
    
    initialiserGrille()
    
    @fenetre.tempsEcoule = 0
    
    # Affichage
    
    @fenetre.afficher()
    
    @fenetre.boutonAide.signal_connect('clicked'){
      puts "> Aide"
      
      #mouvement(EventsMenuJeu.new(jeu))
      mouvement(EventsPreparation.new(jeu)) # DEBUG
    }
    
    @fenetre.boutonMenu.signal_connect('clicked'){
      puts "> Menu"
      
      #mouvement(EventsMenuJeu.new(jeu))
    }
  end
  
  def initialiserGrille()
    
    initialiserConditionsV()
    initialiserConditionsH()
    initialiserTableauJeu()
    
  end
  
  def initialiserConditionsV()
    
    @fenetre.tableauConditionsV.resize(@taille, 3)
    
    0.upto(@taille) do |x|
      0.upto(3) do |y|
        @fenetre.tableauConditionsV.attach_defaults(Gtk::Label.new("0"), x, x+1, y, y+1)
      end
    end
  end
  
  def initialiserConditionsH()
    
    @fenetre.tableauConditionsH.resize(3, @taille)
    
    0.upto(3) do |x|
      0.upto(@taille) do |y|
        @fenetre.tableauConditionsH.attach_defaults(Gtk::Label.new("0"), x, x+1, y, y+1)
      end
    end
  end
  
  def initialiserTableauJeu()
    
    @fenetre.tableauJeu.resize(@taille, @taille)
    
    0.upto(@taille) do |x|
      0.upto(@taille) do |y|
        
        #if (x%5 == 0) && (y%5 == 0) then
        #  @fenetre.tableauJeu.attach_defaults(Gtk::HSeparator.new(), 0, @taille-1, y, y+1)
        #  @fenetre.tableauJeu.attach_defaults(Gtk::HSeparator.new(), x, x+1, 0, @taille-1)
        #end
        
        @fenetre.tableauJeu.attach_defaults(Gtk::Image.new('./Vue/Images/vide.gif'), x, x+1, y, y+1)
      end
    end
  end
  
end


















