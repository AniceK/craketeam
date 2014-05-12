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
require './Vue/Dialogues/DialogueEnregistrer'


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
  @pixCaseVide
  @pixCaseNoircie

  attr_reader :tailleGrille,
              :tailleCase,
              :nbConditionsRangee,
              :optionsTableau,
              :pixCaseVide,
              :pixCaseNoircie

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
      initialiserGrille(520, 400)
    when 15
      initialiserGrille(680, 550)
    when 20
      initialiserGrille(620, 500)
    when 25
      initialiserGrille(730, 600)
    else
      puts "Erreur: La taille n'est pas valide"
    end

    # Affichage

    @fenetre.afficher()
    #@fenetre.move(@jeu.positionX(), @jeu.positionY()) # => @jeu.positionX() renvoie position[0] et Y -> position[1]

    @fenetre.boutonEnregistrer.signal_connect('clicked'){
      puts "> Enregistrer"
  
      doitEnregistrerEtQuitter = dialogueEnregistrer()
  
      if doitEnregistrerEtQuitter then
        
        #puts "> Accueil (Nom de la grille créée: \"" + dialogue.nomSauvegarde + "\")"
        mouvement(EventsAccueil.new(jeu))
        
      else
        
        puts "> Editeur"
        
      end
    }
    
    @fenetre.boutonQuitter.signal_connect('clicked'){
  
      puts "> Quitter"
  
      dialogue = DialogueQuitterEditeur.new(@fenetre.widget())
  
      if dialogue.doitArreterEditeur then
    
        puts "> Accueil"
        @jeu.quitterPartie()
        mouvement(EventsAccueil.new(jeu))
    
      else
    
        puts "> Editeur"  
      end
    }


  end
  
  
  def dialogueEnregistrer()

    dialogue = DialogueEnregistrer.new(@fenetre.widget())

    while true
      
      dialogue.popup.run() do |reponse|
      
        case reponse
        
        when Gtk::Dialog::RESPONSE_ACCEPT
          
          puts "Sauvegarder cliqué !"
          nomSauvegarde = dialogue.entreeNomSauvegarde.text()
        
          if @jeu.sauvegarderPartie(nomSauvegarde) then
            
            puts "Nom de sauvegarde valide !"
            dialogue.popup.destroy()
            return true
            
          else
            
            puts "Nom existant !"
            dialogue.nomExistant(nomSauvegarde)
          
          end
          
        when Gtk::Dialog::RESPONSE_REJECT
          
          puts "Annuler cliqué !"
          dialogue.popup.destroy()
          return false
          
        else
          
          puts "Erreur: Réception boutons Dialogue Enregistrer"
          
        end
      end
    end
  end


  def initialiserGrille(largeurFenetre, hauteurFenetre)

    @fenetre.redimensionner(largeurFenetre, hauteurFenetre)

    if @tailleGrille < 20 then
      @tailleCase = 30
    else
      @tailleCase = 20
    end

    initialiserImages()
    initialiserTableauJeu()

  end


  def caseCliquee(widget, evenement)

    x = (widget.allocation.x / 32) - 1
    y = (widget.allocation.y / 32) - 1

    puts "widget.class = " + widget.class.to_s + "\nCase[" + x.to_s + "][" + y.to_s + "]"

    if evenement.button() == 1 then
  
      if widget.child.pixbuf() == @pixCaseVide then
    
        @jeu.noircir(x, y)
        widget.child.set_pixbuf(@pixCaseNoircie)
    
      elsif widget.child.pixbuf() == @pixCaseNoircie then
    
        @jeu.noircir(x, y)
        widget.child.set_pixbuf(@pixCaseVide)
    
      else
    
        puts "Erreur: case n'est pas considérée comme vide ou noircie"
    
      end
  
    end
  
  end

  # Retourne une case vide cliquable
  def caseDefault()

    imageCaseVide = Gtk::Image.new(@pixCaseVide)

    evenementCase = Gtk::EventBox.new()
    evenementCase.events = Gdk::Event::BUTTON_PRESS_MASK
    evenementCase.add(imageCaseVide)

    evenementCase.signal_connect('button_press_event') { |widget, evenement|
  
      caseCliquee(widget, evenement)
    }

    # => Evenement en cas de cliqué-glissé (drag_enter_event ?)
    #evenementCase.signal_connect('enter_notify_event') { |widget, evenement|
    #  
    #  caseCliquee(widget, evenement)
    #}

    return evenementCase

  end

  def initialiserImages()

    @pixCaseVide = Gdk::Pixbuf.new('../Vue/Images/vide.gif', @tailleCase, @tailleCase)
    @pixCaseNoircie = Gdk::Pixbuf.new('../Vue/Images/noircie.gif', @tailleCase, @tailleCase)
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
    
        @fenetre.tableauJeu.attach(caseDefault(), x, x+1, y, y+1, @optionsTableau, @optionsTableau)
      end
    end
  end

end


















