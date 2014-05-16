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
require './Vue/Dialogues/DialogueEcraserSauvegarde'
require './Vue/Dialogues/DialogueEnregistrer'
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
  # Taille de la grille de jeu
  @tailleConditions
  # Taille maximale des conditions
  @tailleCase
  # Taille d'une case en pixel
  @nbConditionsRangee
  # Nombre de conditions d'une rangée
  @estEnPause
  # Booléen déterminant si le jeu est en pause ou non
  @optionsTableau
  # Contient les options FILL et EXPAND à utiliser pour un tableau
  @chronometre
  # Thread incrémentant une valeur toutes les secondes
  @pixCaseVide
  # Contient l'image d'une case vide
  @pixCaseNoircie
  # COnient l'image d'une case noircie
  
  # Toutes les variables sont en lecture uniquement
  attr_reader :tailleGrille,
              :tailleConditions,
              :tailleCase,
              :nbConditionsRangee,
              :estEnPause,
              :optionsTableau,
              :chronometre,
              :pixCaseVide,
              :pixCaseNoircie
             
  # On peut instancier la classe EventsJeu
  public_class_method :new
  
  # Initialisation de la partie
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
    
   
    # Initialise la grille en fonction de la taille de cette dernière 
    case @tailleGrille
    when 5
      initialiserGrille(500, 300)
    when 10
      initialiserGrille(700, 550)
    when 15
      initialiserGrille(800, 500)
    when 20
      initialiserGrille(1100, 650)
    when 25
      initialiserGrille(1300, 800)
    else
      puts "Erreur: La taille n'est pas valide"
    end
    
    # Prépare le chrono
    self.initialiserChrono()
    
    # Établi nom de sauvegarde par défaut
    if @jeu.profilConnecte?() then
      
      if nomSauvegardeDefaut = @jeu.nomSauvegardeDefaut() then
        
        puts "La sauvegarde en cours a pour nom: " + nomSauvegardeDefaut
        @fenetre.nomSauvegardeDefaut(nomSauvegardeDefaut)
        
      elsif @jeu.nomSauvegardeDefaut() == nil then
          
        puts "Le jeu n'est pas issu d'une sauvegarde (pseudo: " + @jeu.nomProfil() + ")"
        @fenetre.nomSauvegardeDefaut(@jeu.nomProfil() + " " + @tailleGrille.to_s + "x" + @tailleGrille.to_s) 
          
      else
          
        puts "[EventJeu]Erreur: Récupération du nom de sauvegarde si existante"
          
      end
        
    elsif !@jeu.profilConnecte?()
      
      puts "> Pas de nom de sauvegarde par défaut"
      
    else
        
      puts "[EventJeu]Erreur: Mauvais test si profil connecté ou non"
        
    end
    
    # Affichage de tous les éléments de la fenêtre
    @fenetre.afficher()
    
    # Affichage du nécessaire uniquement
    @fenetre.affichageDepart()
    
    # Lancement d'une partie au niveau du moteur
    @jeu.lancerPartie()
    # Lancement de l'incrémentation du chrono
    self.lancerChrono()
    
    # Affiche un popup d'aide
    @fenetre.boutonAide.signal_connect('clicked'){
      puts "> Aide"
      
      message = @jeu.chercherAide()
      
      dialogue = DialogueAide.new(@fenetre.widget(), message)
    }
    
    # Cache la grille et arrête le chrono pour afficher le menu de pause
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
    
    # Permet de sauvegarder la partie avec un nom (si profil connecté)
    @fenetre.boutonSauvegarder.signal_connect('clicked'){
      
      nomSauvegarde = @fenetre.entreeSauvegarde.text()
      
      if nomSauvegarde.length() > 2 then
      
        if @jeu.sauvegarderPartie(nomSauvegarde) then
          
          puts "> Accueil (nom de sauvegarde: " + nomSauvegarde + ")"
          mouvement(EventsAccueil.new(@jeu, position() ))
          
        else
          
          puts "Erreur: nom de sauvegarde existant"
          dialog = DialogueEcraserSauvegarde.new(@fenetre.widget())
          
          if dialog.doitEcraser == true then
            
            puts "Sauvegarde écrasée"
            @jeu.remplacerSauvegarde(nomSauvegarde)
            mouvement(EventsAccueil.new(@jeu, position() ))
            
          elsif dialog.doitEcraser == false then
            
            puts "Sauvegarde non écrasée"
            
          end
          
        end
          
      else
        
        puts "> Nom de sauvegarde trop court ("+ nomSauvegarde.length.to_s + " caractère(s))"
        @fenetre.texteInfosSauvegarde.show_all()
          
      end
    }
    
    # RAZ de la grille
    @fenetre.boutonNettoyerGrille.signal_connect('clicked'){
      
      puts "> Nettoyer grille"
      @jeu.nettoyerGrille()
      self.toutActualiser()
      @fenetre.texteInfosNettoyer.show_all()
    }
    
    # Retour au menu principal à partir du menu de pause
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
    
    # Retour à la préparation d'une partie
    @fenetre.boutonNouvellePartie.signal_connect('clicked'){
      
      @jeu.quitterPartie()
      
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
    
    # Retour au menu principal
    @fenetre.boutonFinMenuPrincipal.signal_connect('clicked'){
      
      puts "> Menu Principal"
      
      @jeu.quitterPartie()
      mouvement(EventsAccueil.new(@jeu, position() ))
    }
    
    # Enregistre la grille dans les grilles perso
    @fenetre.boutonEnregistrerGrille.signal_connect('clicked'){
      
      puts "> Enregistrer Grille"
      
      doitEnregistrerEtQuitter = dialogueEnregistrer()
  
      if doitEnregistrerEtQuitter then
        
        puts "> Accueil (Nom de la grille créée: \"" + doitEnregistrerEtQuitter + "\")"
        @jeu.quitterPartie()
        mouvement(EventsAccueil.new(@jeu, position() ))
        
      else
        
        puts "> Jeu"
        
      end
    }
    
  end
  
  # Ouvre une fenêtre popup pour enregistrer la grille une fois celle-ci terminée
  def dialogueEnregistrer()

    dialogue = DialogueEnregistrer.new(@fenetre.widget())

    while true
      
      dialogue.popup.run() do |reponse|
      
        case reponse
        
        when Gtk::Dialog::RESPONSE_ACCEPT
          
          nomSauvegarde = dialogue.entreeNomSauvegarde.text()
        
          if @jeu.sauvegarderGrille(nomSauvegarde) then
            
            puts "Nom de sauvegarde valide"
            dialogue.popup.destroy()
            return nomSauvegarde
            
          else
            
            puts "Nom existant !"
            dialogue.nomExistant(nomSauvegarde)
          
          end
          
        when Gtk::Dialog::RESPONSE_REJECT
          
          dialogue.popup.destroy()
          return false
          
        when Gtk::Dialog::RESPONSE_DELETE_EVENT
          
          puts "Fenêtre fermée !"
          dialogue.popup.destroy()
          return false
          
        else
          
          puts "[EventsEditeur]Erreur: Réception signal Dialogue Enregistrer ==> " + reponse.to_s
          
        end
      end
    end
  end
  
  # Initialise le Thread du chronomètre à zéro et attend son lancement
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
  
  # Lance le Thread du chronomètre
  def lancerChrono()
    
    @chronometre.run()
  end
  
  # Arrête le Thread du chronomètre
  def arreterChrono()
    
    @chronometre.exit()
  end
  
  # Initialise la grille en redimensionnant la taille de la fenêtre pour s'adapter à la taille de la grille
  # Puis remplit le tableau de case et de conditions
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
    
    self.initialiserImages()
    self.initialiserConditionsV()
    self.initialiserConditionsH()
    self.initialiserTableauJeu()
    
  end
  
  # Prépare les images à mettre dans les cases
  def initialiserImages()
    
    @vide = Gdk::Pixbuf.new('../Vue/Images/vide.gif', @tailleCase, @tailleCase)
    @noircie = Gdk::Pixbuf.new('../Vue/Images/noircie.gif', @tailleCase, @tailleCase)
    @marquee = Gdk::Pixbuf.new('../Vue/Images/marquee.gif', @tailleCase, @tailleCase)
  end
  
  # Action à réaliser après un clic sur une case
  def caseCliquee(widget, evenement)
    
    x = widget.coordonneeX
    y = widget.coordonneeY
    
    if evenement.button() == 1 then
      
      if widget.etatCourant() == @vide then
        
        estTermine = @jeu.noircir(x, y)
        widget.changerEtat(@noircie)
        
      elsif widget.etatCourant() == @noircie then
        
        estTermine = @jeu.noircir(x, y)
        widget.changerEtat(@vide)
        
      end
      
      if estTermine then
        
        puts "> Partie gagnée (Temps = " + estTermine.to_s + ", Score = " + (estTermine * 3).to_s + ")"
        
        self.nettoyerGrilleFinie()
        
        @fenetre.affichageFin(estTermine)
        
      end
     
      # Gestion du marquage
      
    elsif evenement.button() == 3 then
      
      if widget.etatCourant() == @marquee then
        
        widget.changerEtat(@vide)
        @jeu.marquer(x, y)
        
      elsif widget.etatCourant() == @vide then
        
        widget.changerEtat(@marquee)
        @jeu.marquer(x, y)
        
      end
      
    else
      
      puts "Mauvaise gestion caseCliquée"
    end
      
  end
  
  # Remplit le tableau de conditions verticales
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
         while (xCondition >= 0) && (x >= 0) do
           
           condition = Gtk::Label.new("")
         
           # Tant qu'on obtient une condition vide et que l'on reste dans la taille des conditions
           while (condition.text == "") && (xCondition >= 0) do
             
             xCondition -= 1
             
             valeurCondition = @jeu.conditionV(y, xCondition)
             
             # On prend la condition de la ligne et on décrémente la variable interne
             condition.set_text(valeurCondition.to_s)
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
  
  # Remplit le tableau de conditions horizontales
  def initialiserConditionsH()
    
    #@fenetre.tableauConditionsH.resize(3, @tailleGrille)
    
    0.upto(@tailleGrille - 1) do |x|
      
      @nbConditionsRangee = @jeu.nbConditionsH(x)
      
      if @nbConditionsRangee > 0 then
        
        # Variable incrémentant la boucle interne
        yCondition = @tailleConditions
        y = @tailleConditions - 1
           
         # Tant que l'on est pas arrivé à la dernière conditions
         while (yCondition >= 0) && (y >= 0) do
           
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
         
      else
         
         puts "[EventJeu]Erreur: la ligne " + x.to_s + "n'a pas de conditions"
      end
    end
  end

  # Remplit le tableau par des cases vides, noircies ou marquées selon leur état dans le jeu
  def initialiserTableauJeu()
    
    0.upto(@tailleGrille - 1) do |x|
      0.upto(@tailleGrille - 1) do |y|
        
        # Ajout séparation toutes les 5 lignes
        
        #if (x%5 == 0) && (y%5 == 0) then
        #  @fenetre.tableauJeu.attach_defaults(Gtk::HSeparator.new(), 0, @tailleGrille-1, y, y+1)
        #  @fenetre.tableauJeu.attach_defaults(Gtk::HSeparator.new(), x, x+1, 0, @tailleGrille-1)
        #end
        
        case @jeu.etatCase(x, y)
          
        when 0 then etat = @vide
        when 1 then etat = @noircie
        when 2 then etat = @marquee
          
        else puts "Erreur: L'état de la case à initialiser est inconnu ==> " + @jeu.etatCase(x, y).to_s
          
        end
        
        caseCartesienne = CaseCartesienne.new(x, y, etat)
        
        # Lorsqu'on clic, on noircie tout ce qui survolé jusqu'au déclic
        signalCaseCliquee = caseCartesienne.signal_connect('button_press_event') { |widget, evenement|
      
          caseCliquee(widget, evenement)
        }
        
        caseCartesienne.ajouterSignalID(signalCaseCliquee)
        
        @fenetre.tableauJeu.attach(caseCartesienne, x, x+1, y, y+1, @optionsTableau, @optionsTableau)
      end
    end
  end
    
  # Permet de changer l'état des cases du tableau en fonction de l'état dans le jeu
  # Utile ici pour la remise à zéro de la grille
  def toutActualiser()
    
    @fenetre.tableauJeu.each{ |caseTableau|
      
      x = caseTableau.coordonneeX
      y = caseTableau.coordonneeY
      
      case @jeu.etatCase(x, y)
        
      when 0 then etat = @vide
      when 1 then etat = @noircie
      when 2 then etat = @marquee
        
      else
          
          puts "Erreur: L'état de la case à initialiser est inconnu ==> " + @jeu.etatCase(x, y).to_s
        
      end
      
      caseTableau.changerEtat(etat)
    }
  end
  
  # Actualise la grille en enlevant les cases marquées et les signaux de toutes les cases pour l'affichage de fin
  def nettoyerGrilleFinie()
    
    @fenetre.tableauJeu.each{ |caseTableau|
      
      x = caseTableau.coordonneeX
      y = caseTableau.coordonneeY
      
      case @jeu.etatCase(x, y)
        
      when 0 then etat = @vide
      when 1 then etat = @noircie
      when 2 then etat = @vide
        
      else
          
          puts "Erreur: L'état de la case à initialiser est inconnu ==> " + @jeu.etatCase(x, y).to_s
        
      end
      
      caseTableau.changerEtat(etat)
      
      signalID = caseTableau.recupererSignalID()
      caseTableau.signal_handler_disconnect(signalID)
    }
  end
  
end


















