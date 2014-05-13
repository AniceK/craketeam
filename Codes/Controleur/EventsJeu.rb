# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require './Vue/Fenetres/FenetreJeu'
require './Vue/Elements/CaseCartesienne'
require './Vue/Dialogues/DialogueQuitterPartie'
require './Vue/Dialogues/DialogueAide'

#===============================================================================#
#                                                                               #
#               La classe EventsJeu créé une fenêtre de jeu.                    #
#      Elle permet au joueur de jouer une partie sur une grille de picross.     #
#   Elle met également en place le menu de pause qui est intégré à la fenêtre.  #
#                                                                               #
#===============================================================================#


class EventsJeu < Events
  
  @tailleGrille
  @tailleConditions
  @tailleCase
  @nbConditionsRangee
  @estEnPause
  @optionsTableau
  @chronometre
  @pixCaseVide
  @pixCaseNoircie
  @evenementCase
  @decalagePositionX
  @decalagePositionY
  
  attr_reader :tailleGrille,
              :tailleConditions,
              :tailleCase,
              :nbConditionsRangee,
              :estEnPause,
              :optionsTableau,
              :chronometre,
              :pixCaseVide,
              :pixCaseNoircie,
              :decalagePositionX,
              :decalagePositionY,
              :evenementCase
              
              
  
  public_class_method :new
  
  def initialize(jeu, position)
    
    @fenetre = FenetreJeu.new()
    
    super(jeu, position)
    
    
    ################################################################
    #                                                              #
    #                             Jeu                              #
    #                                                              #
    ################################################################
    
    @estEnPause = false
    @tailleGrille = @jeu.tailleGrille()
    @tailleConditions = (@tailleGrille / 2.0).round()
    @tailleCase = 30
    @nbConditionsRangee = 0
    @optionsTableau = Gtk::FILL | Gtk::SHRINK
    
    
    case @tailleGrille
    when 5
      initialiserGrille(500, 300)
      initialiserPositionsCases(2, 3)
    when 10
      initialiserGrille(700, 550)
      initialiserPositionsCases(3, 5)
    when 15
      initialiserGrille(750, 550)
      initialiserPositionsCases(4, 5)
    when 20
      initialiserGrille(1000, 700)
      initialiserPositionsCases(5, 6)
    when 25
      initialiserGrille(1300, 800)
      initialiserPositionsCases(6, 6)
    else
      puts "Erreur: La taille n'est pas valide"
    end
    
    self.initialiserChrono()
    
    @fenetre.afficher()
    
    @fenetre.affichageDepart()
    
    @jeu.lancerPartie()
    self.lancerChrono()
    
    @fenetre.boutonAide.signal_connect('clicked'){
      puts "> Aide"
      
      message = @jeu.chercherAide()
      
      dialogue = DialogueAide.new(@fenetre.widget(), message)
    }
    
    @fenetre.boutonPause.signal_connect('clicked'){
      
      # Inversion du booléen
      @estEnPause = @estEnPause.!

      if @estEnPause
        
        @jeu.partieEnPause()
        
        if @jeu.profilConnecte?() then
        
          @fenetre.affichagePauseProfil()
          
        elsif !@jeu.profilConnecte?() then
          
          @fenetre.affichagePauseSimple()
          
        end
        
      elsif !@estEnPause then
        
        @fenetre.affichageJeu()
        self.lancerChrono()
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
      
      nomSauvegarde = @fenetre.entreeSauvegarde.text()
      puts "> Accueil (nom de sauvegarde: " + nomSauvegarde + ")"
      
      if @jeu.sauvegarderPartie(nomSauvegarde) then
        mouvement(EventsAccueil.new(@jeu, position() ))
      else
        puts "Erreur: nom de sauvegarde existant"
      end
    }
    
    @fenetre.boutonPauseMenuPrincipal.signal_connect('clicked'){
      
      puts "> Dialogue Menu Principal"
      
      dialogue = DialogueQuitterPartie.new(@fenetre.widget())
      
      if dialogue.doitArreterPartie then
        
        puts "> Accueil"
        @jeu.quitterPartie()
        mouvement(EventsAccueil.new(@jeu, position() ))
        
      else
        
        puts "> Jeu"
        
      end
    }
    
    
    ################################################################
    #                                                              #
    #                        Partie Gagnée                         #
    #                                                              #
    ################################################################
    
    
    @fenetre.boutonNouvellePartie.signal_connect('clicked'){
      
      if @jeu.profilConnecte?() then
        
        puts "> Choix Partie"
        mouvement(EventsChoixPartie.new(@jeu, position() ))
      
      elsif !@jeu.profilConnecte?() then
        
        puts "> Préparation Partie"
        mouvement(EventsPreparation.new(@jeu, position() ))
        
      else
        
        puts "Erreur: Problème booléen indiquant si un profil est connecté"
        
      end
    }
    
    @fenetre.boutonFinMenuPrincipal.signal_connect('clicked'){
      
      puts "> Menu Principal"
      
      mouvement(EventsAccueil.new(@jeu, position() ))
    }
    
  end
  
  def initialiserChrono()
    
    @chronometre = Thread.new {
      
      while(true)
        
        temps = @jeu.tempsActuel()
        @fenetre.minutes = (temps / 60).round()
        @fenetre.secondes = temps % 60
        
        @fenetre.actualiserTemps()
        
        sleep 1.0
        
        if @estEnPause then Thread.stop() end
      end
    }
    
  end
  
  def lancerChrono()
    
    @chronometre.run()
  end
  
  def arreterChrono()
    
    @chronometre.exit()
  end
  
  
  def initialiserGrille(largeurFenetre, hauteurFenetre)
    
    @fenetre.redimensionner(largeurFenetre, hauteurFenetre)
    
    puts "Taille la grille = " + @tailleGrille.to_s
    
    if @tailleGrille < 15 then
      @tailleCase = 30
      @fenetre.grandesConditions()
    else
      @tailleCase = 20
      @fenetre.petitesConditions()
    end
    
    initialiserImages()
    initialiserConditionsV()
    initialiserConditionsH()
    initialiserTableauJeu()
    
  end
  
  def initialiserImages()
    
    @vide = Gdk::Pixbuf.new('../Vue/Images/vide.gif', @tailleCase, @tailleCase)
    @noircie = Gdk::Pixbuf.new('../Vue/Images/noircie.gif', @tailleCase, @tailleCase)
    @marquee = Gdk::Pixbuf.new('../Vue/Images/marquee.gif', @tailleCase, @tailleCase)
  end
  
  def initialiserPositionsCases(x, y)
    
    @decalagePositionX = x
    @decalagePositionY = y
  end
  
  def caseCliquee(widget, evenement)
    
    x = widget.coordonneeX
    y = widget.coordonneeY
    
    puts "Case[" + x.to_s + "][" + y.to_s + "]"
    
    if evenement.button() == 1 then
      
      if widget.etatCourant() == @vide then
        
        @jeu.noircir(x, y)
        widget.changerEtat(@noircie)
        
      elsif widget.etatCourant() == @noircie then
        
        @jeu.noircir(x, y)
        widget.changerEtat(@vide)
        
      end
      
      if temps = @jeu.termine?() then
        
        puts "> Partie gagnée (Temps = " + temps.to_s + ", Score = " + (temps * 3).to_s + ")"
        
        #@evenementCase.signal_emit_stop('button_press_event') # => Empêcher appuie sur case
        # => Nettoyage cases marquées
        @jeu.quitterPartie()
        @fenetre.affichageFin(temps)
        
      end
     
      # Gestion du marquage
      
    elsif evenement.button() == 3 then
      
      if widget.etatCourant() == @marquee then
        
        widget.changerEtat(@vide)
        
      elsif widget.etatCourant() == @vide then
        
        widget.changerEtat(@marquee)
        
      end
      
    else
      
      puts "Mauvaise gestion caseCliquée"
    end
      
  end
  
  def initialiserConditionsV()
    
    #@fenetre.tableauConditionsV.resize(@tailleGrille, 3)
    
    0.upto(@tailleGrille - 1) do |y|
      
      @nbConditionsRangee = @jeu.nbConditionsV(y)
      
      if @nbConditionsRangee == 0 then
        
        @fenetre.tableauConditionsV.attach(Gtk::Label.new("0"), y, y+1, @tailleConditions - 1, @tailleConditions, @optionsTableau, @optionsTableau)
        
      else
        
        # Variable incrémentant la boucle interne
        xCondition = @tailleConditions
        x = @tailleConditions - 1
           
         # Tant que l'on est pas arrivé à la dernière conditions
         while (xCondition >= 0) && (x > 0) do
           
           condition = Gtk::Label.new("")
         
           # Tant qu'on obtient une condition vide et que l'on reste dans la taille des conditions
           while (condition.text == "") && (xCondition >= 0) do
             
             xCondition -= 1
             
             # On prend la condition de la ligne et on décrémente la variable interne
             condition.set_text(@jeu.conditionV(y, xCondition).to_s)
             
           end
           
           # Si la condition est à prendre en compte
           if xCondition >= 0 then
               
             # On ajoute la condition non-vide au tableau par le bas  
             @fenetre.tableauConditionsV.attach(condition, y, y+1, x, x+1, @optionsTableau, @optionsTableau)
             
             x -= 1
           end
         end
      end
    end
  end
  
  def initialiserConditionsH()
    
    #@fenetre.tableauConditionsH.resize(3, @tailleGrille)
    
    0.upto(@tailleGrille - 1) do |x|
      
      @nbConditionsRangee = @jeu.nbConditionsH(x)
      
      if @nbConditionsRangee == 0 then
        
        @fenetre.tableauConditionsH.attach(Gtk::Label.new("0"), x, x+1, @tailleConditions - 1, @tailleConditions, @optionsTableau, @optionsTableau)
        
      else
        
        # Variable incrémentant la boucle interne
        yCondition = @tailleConditions
        y = @tailleConditions - 1
           
         # Tant que l'on est pas arrivé à la dernière conditions
         while (yCondition >= 0) && (y > 0) do
           
           condition = Gtk::Label.new("")
         
           # Tant qu'on obtient une condition vide et que l'on reste dans la taille des conditions
           while (condition.text == "") && (yCondition >= 0) do
             
             yCondition -= 1
             
             # On prend la condition de la ligne et on décrémente la variable interne
             condition.set_text(@jeu.conditionH(x, yCondition).to_s)
             
           end
           
           # Si la condition est à prendre en compte
           if yCondition >= 0 then
               
             # On ajoute la condition non-vide au tableau par la droite  
             @fenetre.tableauConditionsH.attach(condition, y, y+1, x, x+1, @optionsTableau, @optionsTableau)
             
             y -= 1
           end
         end
      end
    end
  end

  def initialiserTableauJeu()
    
    0.upto(@tailleGrille - 1) do |x|
      0.upto(@tailleGrille - 1) do |y|
        
        # Ajout séparation toutes les 5 lignes
        
        #if (x%5 == 0) && (y%5 == 0) then
        #  @fenetre.tableauJeu.attach_defaults(Gtk::HSeparator.new(), 0, @tailleGrille-1, y, y+1)
        #  @fenetre.tableauJeu.attach_defaults(Gtk::HSeparator.new(), x, x+1, 0, @tailleGrille-1)
        #end
        
        # => À décommenter quand méthode de récupération de l'état de la case[x,y] opérationnelle
        
        case @jeu.etatCase(x, y)
          
        when 0 then etat = @vide
        when 1 then etat = @noircie
        when 2 then etat = @marquee
          
        else puts "Erreur: L'état de la case à initialiser est inconnu ==> " + @jeu.etatCase(x, y).to_s
          
        end
        
        caseCartesienne = CaseCartesienne.new(x, y, etat)  # => Remplacer "@vide" par "etat"
        
        caseCartesienne.signal_connect('button_press_event') { |widget, evenement|
      
          caseCliquee(widget, evenement)
        }
        
        @fenetre.tableauJeu.attach(caseCartesienne, x, x+1, y, y+1, @optionsTableau, @optionsTableau)
      end
    end
  end
  
end


















