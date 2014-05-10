# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require './Vue/Fenetres/FenetreEditeur'
require './Vue/Dialogues/DialogueQuitterEditeur'


#===============================================================================#
#                                                                               #
#               La classe EventsJeu créé une fenêtre de jeu.                    #
#      Elle permet au joueur de jouer une partie sur une grille de picross.     #
#   Elle met également en place le menu de pause qui est intégré à la fenêtre.  #
#                                                                               #
#===============================================================================#


class EventsEditeur < Events
  
  @tailleGrille
  @tailleCase
  @nbConditionsRangee
  @optionsTableau
  
  attr_reader :tailleGrille,
              :tailleCase,
              :nbConditionsRangee,
              :optionsTableau
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    
    ################################################################
    #                                                              #
    #                             Jeu                              #
    #                                                              #
    ################################################################
    
    @tailleGrille = @jeu.tailleGrille()
    @tailleCase = 30
    @nbConditionsRangee = 0
    @optionsTableau = Gtk::FILL | Gtk::SHRINK
    
    
    @fenetre = FenetreEditeur.new()
    
    case @tailleGrille
    when 5
      initialiserGrille(350, 230)
    when 10
      initialiserGrille(700, 550)
    when 15
      initialiserGrille(750, 550)
    when 20
      initialiserGrille(900, 700)
    when 25
      initialiserGrille(1100, 800)
    else
      puts "Erreur: La taille n'est pas valide"
    end
    
    # Affichage
    
    @fenetre.afficher()
    
    @fenetre.boutonEnregistrer.signal_connect('clicked'){
      puts "> Enregistrer"
      
      #@fenetre.afficherEnregistrement()
      # OU #
      #mouvement(DialogueEnregistrer.new(jeu)) # DEBUG
    }
    
    @fenetre.boutonQuitter.signal_connect('clicked'){
      
      puts "> Quitter"
      
      dialogue = DialogueQuitterEditeur.new()
      
      if dialogue.doitArreterEditeur then
        
        mouvement(EventsAccueil.new(jeu))
      end
    }
    
    
  end
  
  
  def initialiserGrille(largeurFenetre, hauteurFenetre)
    
    @fenetre.redimensionner(largeurFenetre, hauteurFenetre)
    
    if @tailleGrille < 15 then
      @tailleCase = 30
    else
      @tailleCase = 20
    end
  
    initialiserTableauJeu()
    
  end
  
  
  
  # Retourne une case vide cliquable
  def caseVide()
    
    pixCaseVide = Gdk::Pixbuf.new('../Vue/Images/vide.gif', @tailleCase, @tailleCase)
    imageCaseVide = Gtk::Image.new(pixCaseVide)
    eventCaseVide = Gtk::EventBox.new.add(imageCaseVide)
    
    eventCaseVide.signal_connect("button_press_event") do
      puts "Case vide cliquée"
    end
    
    return eventCaseVide
  end
  
  # Retourne une case noircie cliquable
  def caseNoircie()
    
    pixCaseNoircie = Gdk::Pixbuf.new('../Vue/Images/noircie.gif', @tailleCase, @tailleCase)
    imageCaseNoircie = Gtk::Image.new(pixCaseNoircie)
    eventCaseNoircie = Gtk::EventBox.new.add(imageCaseNoircie)
    
    eventCaseNoircie.signal_connect("button_press_event") do
      puts "Case noircie cliquée"
    end
    
    return eventCaseNoircie
  end
  
  # Retourne une case marquée cliquable
  def caseMarquee()
    
    pixCaseMarquee = Gdk::Pixbuf.new('../Vue/Images/marquee.gif', @tailleCase, @tailleCase)
    imageCaseMarquee = Gtk::Image.new(pixCaseMarquee)
    eventCaseMarquee = Gtk::EventBox.new.add(imageCaseMarquee)
    
    eventCaseMarquee.signal_connect("button_press_event") do
      puts "Case marquée cliquée"
    end
    
    return eventCaseMarquee
  end
  
  def initialiserTableauJeu()
    
    #@fenetre.tableauJeu.resize(@tailleGrille, @tailleGrille)
    
    1.upto(@tailleGrille) do |x|
      1.upto(@tailleGrille) do |y|
        
        # Ajout séparation toutes les 5 lignes
        
        #if (x%5 == 0) && (y%5 == 0) then
        #  @fenetre.tableauJeu.attach_defaults(Gtk::HSeparator.new(), 0, @tailleGrille-1, y, y+1)
        #  @fenetre.tableauJeu.attach_defaults(Gtk::HSeparator.new(), x, x+1, 0, @tailleGrille-1)
        #end
        
        caseTableau = caseVide()
        
        @fenetre.tableauJeu.attach(caseTableau, x, x+1, y, y+1, @optionsTableau, @optionsTableau)
      end
    end
  end
  
end


















