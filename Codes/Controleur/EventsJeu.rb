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
require './Vue/Dialogues/DialogueMenuPrincipal'


#===============================================================================#
#                                                                               #
#               La classe EventsJeu créé une fenêtre de jeu.                    #
#      Elle permet au joueur de jouer une partie sur une grille de picross.     #
#   Elle met également en place le menu de pause qui est intégré à la fenêtre.  #
#                                                                               #
#===============================================================================#


class EventsJeu < Events
  
  @tailleGrille
  @tailleCase
  @nbConditionsRangee
  @estEnPause
  @optionsTableau
  
  attr_reader :tailleGrille, :tailleCase, :nbConditionsRangee, :estEnPause, :optionsTableau
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    
    ################################################################
    #                                                              #
    #                             Jeu                              #
    #                                                              #
    ################################################################
    
    @estEnPause = false
    @tailleGrille = @jeu.tailleGrille()
    @tailleCase = 30
    @nbConditionsRangee = 0
    @optionsTableau = Gtk::FILL | Gtk::SHRINK
    
    
    @fenetre = FenetreJeu.new()
    
    case @tailleGrille
    when 5
      initialiserGrille(500, 300)
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
    
    
    #@fenetre.tempsEcoule = 0
    
    # Affichage
    
    @fenetre.afficher()
    @fenetre.affichageJeu()
    @fenetre.lancerChrono()
    @jeu.lancerPartie()
    
    @fenetre.boutonAide.signal_connect('clicked'){
      puts "> Aide"
      
      #mouvement(EventsMenuJeu.new(jeu))
      mouvement(EventsPreparation.new(jeu)) # DEBUG
    }
    
    @fenetre.boutonPause.signal_connect('clicked'){
      
      # Inversion du booléen
      @estEnPause = @estEnPause.!

      if @estEnPause
        
        @jeu.partieEnPause()
        
        if jeu.profilConnecte?() then
        
          @fenetre.affichagePauseSimple()
          
        elsif !jeu.profilConnecte?() then
          
          @fenetre.affichagePauseProfil()
          
        end
        
      elsif !@estEnPause then
        
        @fenetre.affichageJeu()
        @jeu.lancerPartie()
        
      else
        puts "Erreur du booléen \"@estEnPause\" déterminant la pause ou la lecture"
      end
    }
    
    
    ################################################################
    #                                                              #
    #                          Menu Pause                          #
    #                                                              #
    ################################################################
    
    @fenetre.boutonSauvegarder.signal_connect('clicked'){
      
      puts "> Accueil (nom de sauvegarde: " + @fenetre.entreeSauvegarde.text() + ")"
      mouvement(EventsAccueil.new(jeu))
    }
    
    @fenetre.boutonMenuPrincipal.signal_connect('clicked'){
      
      puts "> Dialogue Menu Principal"
      
      dialogue = DialogueMenuPrincipal.new()
      
      if dialogue.doitArreterPartie() then
        
        mouvement(EventsAccueil.new(jeu))
      end
    }
    
  end
  
  
  
  def initialiserGrille(largeurFenetre, hauteurFenetre)
    
    @fenetre.redimensionner(largeurFenetre, hauteurFenetre)
    
    if @tailleGrille < 15 then
      @tailleCase = 30
      @fenetre.grandesConditions()
    else
      @tailleCase = 20
      @fenetre.petitesConditions()
    end
    
    initialiserConditionsV()
    initialiserConditionsH()
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
  
  def initialiserConditionsV()
    
    #@fenetre.tableauConditionsV.resize(@tailleGrille, 3)
    
    0.upto(@tailleGrille - 1) do |y|
      
      @nbConditionsRangee = @jeu.nbConditionsV(y)
      
        0.upto(@nbConditionsRangee) do |x|
          
          if @nbConditionsRangee != 0 then
            
            condition = Gtk::Label.new("")
            condition.set_text(@jeu.conditionV(y, x).to_s)
            @fenetre.tableauConditionsV.attach(condition, y, y+1, x, x+1, @optionsTableau, @optionsTableau)
          end
            
        end
    end
  end
  
  def initialiserConditionsH()
    
    #@fenetre.tableauConditionsH.resize(3, @tailleGrille)
    
    0.upto(@tailleGrille - 1) do |x|
      
      @nbConditionsRangee = @jeu.nbConditionsH(x)
      
      0.upto(@nbConditionsRangee) do |y|
        
        
        
        if @nbConditionsRangee != 0 then
          
          condition = Gtk::Label.new("")
          condition.set_text(@jeu.conditionV(x, y).to_s)
          @fenetre.tableauConditionsH.attach(condition, y, y+1, x, x+1, @optionsTableau, @optionsTableau)
        end
        
      end
    end
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


















