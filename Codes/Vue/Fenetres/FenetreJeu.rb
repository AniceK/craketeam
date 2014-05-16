# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreJeu < Fenetre
  
  @texteTemps
  # Affiche le texte "Temps écoulé :"
  @minutes
  # Contient les minutes écoulées
  @secondes
  # Contient les secondes écoulées
  @afficheTemps
  @hBoxTemps
  @tableauGeneral
  @tableauConditionsV
  @tableauConditionsH
  @tableauJeu
  @boutonAide
  @boutonPause
  @imagePause
  @imageLecture
  @vBoxDroite
  
  @boutonPauseMenuPrincipal
  @entreeSauvegarde
  @boutonSauvegarder
  @texteInfosSauvegarde
  @boutonNettoyerGrille
  @texteInfosNettoyer
  @vBoxPause
  
  @texteGagne
  @boutonNouvellePartie
  @boutonFinMenuPrincipal
  @boutonEnregistrerGriller
  @vBoxNavigation
  
  
  attr_reader :texteTemps,
              :hBoxTemps,
              :boutonAide,
              :boutonPause,
              :imagePause,
              :imageLecture,
              :vBoxDroite,
              :afficheTemps,
              
              
              :boutonPauseMenuPrincipal,
              :entreeSauvegarde,
              :boutonSauvegarder,
              :texteInfosSauvegarde,
              :boutonNettoyerGrille,
              :texteInfosNettoyer,
              :vBoxPause,
              
              :boutonNouvellePartie,
              :texteGagne,
              :boutonFinMenuPrincipal,
              :boutonEnregistrerGrille,
              :vBoxNavigation
              
  attr_accessor :tableauConditionsV,
                :tableauConditionsH,
                :tableauJeu,
                :minutes,
                :secondes
  
  public_class_method :new
  
  def initialize()
    super()
    
    
    ################################################################
    #                                                              #
    #                          Menu Pause                          #
    #                                                              #
    ################################################################
    
    #==================================================#
    #           Déclaration / Initialisation           #
    #==================================================#
    
    @boutonPauseMenuPrincipal = Gtk::Button.new("Menu Principal")
    texteSauvegarde = Gtk::Label.new("Nom de la sauvegarde :")
    @entreeSauvegarde = Gtk::Entry.new()
    @boutonSauvegarder = Gtk::Button.new("Sauvegarder")
    @texteInfosSauvegarde = Gtk::Label.new.set_markup("<span foreground='red'>Le nom de sauvegarde\ndoit contenir\nau moins 3 lettres</span>")
    @boutonNettoyerGrille = Gtk::Button.new("Nettoyer Grille")
    @texteInfosNettoyer = Gtk::Label.new.set_markup("<span foreground='red'>La grille est nettoyée</span>")
    
    #==================================================#
    #               Paramètrage éléments               #
    #==================================================#
    
    @boutonPauseMenuPrincipal.set_size_request(150, 30)
    @entreeSauvegarde.set_max_length(30)
    @boutonSauvegarder.set_size_request(150, 30)
    @boutonNettoyerGrille.set_size_request(150, 30)
    
    #==================================================#
    #                  Déclaration Box                 #
    #==================================================#
    
    @vBoxSauvegarde = Gtk::VBox.new(true, 0)
    vBoxNettoyer = Gtk::VBox.new(true, 0)
    @vBoxPause = Gtk::VBox.new(true, 0)
    
    #==================================================#
    #                 Remplissage Box                  #
    #==================================================#
    
    @vBoxSauvegarde.pack_start(texteSauvegarde, false, false, 0)
    @vBoxSauvegarde.pack_start(@entreeSauvegarde, false, false, 0)
    @vBoxSauvegarde.pack_start(@boutonSauvegarder, false, false, 0)
    @vBoxSauvegarde.pack_start(@texteInfosSauvegarde, false, false, 0)
    
    vBoxNettoyer.pack_start(@boutonNettoyerGrille, false, false, 0)
    vBoxNettoyer.pack_start(@texteInfosNettoyer, false, false, 0)
    
    @vBoxPause.pack_start(@vBoxSauvegarde, false, false, 0)
    @vBoxPause.pack_start(vBoxNettoyer, false, false, 0)
    @vBoxPause.pack_end(@boutonPauseMenuPrincipal, false, false, 0)
    
        
    ################################################################
    #                                                              #
    #                          Chronomètre                          #
    #                                                              #
    ################################################################
    
    
    @texteTemps = Gtk::Label.new("Temps écoulé :")
    @secondes = 0
    @minutes = 0
    
    
    ################################################################
    #                                                              #
    #                             Jeu                              #
    #                                                              #
    ################################################################
    
    #==================================================#
    #           Déclaration / Initialisation           #
    #==================================================#
    
    @fenetre.set_title("Jouez !")
    
    @afficheTemps =  Gtk::Label.new("")
    
    @boutonAide = Gtk::Button.new('Aide')
    @boutonPause = Gtk::Button.new()
    
    @tableauGeneral = Gtk::Table.new(0, 0, false)
    @tableauConditionsV = Gtk::Table.new(0, 0, false)
    @tableauConditionsH = Gtk::Table.new(0, 0, true)
    @tableauJeu = Gtk::Table.new(0, 0, true)
    tableauDefile = Gtk::ScrolledWindow.new
    
    pixPause = Gdk::Pixbuf.new('../Vue/Images/pause.gif')
    pixLecture = Gdk::Pixbuf.new('../Vue/Images/lecture.gif')
    
    @imagePause = Gtk::Image.new(pixPause)
    @imageLecture = Gtk::Image.new(pixLecture)
    
    @boutonAide.set_size_request(80, 30)
    
    @boutonPause.set_image(imagePause)

    @tableauConditionsH.set_column_spacings(5)
    
    @tableauJeu.set_column_spacings(2)
    @tableauJeu.set_row_spacings(2)
    
    @tableauGeneral.set_row_spacings(10)
    @tableauGeneral.set_column_spacings(10)
    
    #==================================================#
    #               Gestion alignement                 #
    #==================================================#
    
    @alignePause = Gtk::Alignment.new(0.5,0,0,0)
    @alignePause.add(@boutonPause)
    
    @aligneConditionsH = Gtk::Alignment.new(1,0,0,1)
    @aligneConditionsH.add(@tableauConditionsH)
    
    @aligneConditionsV = Gtk::Alignment.new(0,1,1,0)
    @aligneConditionsV.add(@tableauConditionsV)
    
    #==================================================#
    #               Remplissage tableau                #
    #==================================================#
    
    @tableauGeneral.attach_defaults(@aligneConditionsV, 1, 2, 0, 1)
    @tableauGeneral.attach_defaults(@aligneConditionsH, 0, 1, 1, 2)
    @tableauGeneral.attach_defaults(@tableauJeu, 1, 2, 1, 2)
    
    #==================================================#
    #                  Déclaration Box                 #
    #==================================================#
    
    @hBoxTemps = Gtk::HBox.new(true, 0)
    
    #==================================================#
    #                 Paramètrage Box                  #
    #==================================================#
    
    @hBoxTemps.set_border_width(5)
    
    #==================================================#
    #                  Remplissage Box                 #
    #==================================================#
    
    @hBoxTemps.pack_start(@texteTemps, false, false, 0)
    @hBoxTemps.pack_start(@afficheTemps, false, false, 20)
    
    
    ################################################################
    #                                                              #
    #                        Partie Gagnée                         #
    #                                                              #
    ################################################################
    
    
    @boutonNouvellePartie = Gtk::Button.new('Nouvelle Partie')
    @boutonFinMenuPrincipal = Gtk::Button.new('Menu Principal')
    @boutonEnregistrerGrille = Gtk::Button.new('Enregistrer Grille')
    
    @boutonNouvellePartie.set_size_request(-1, 30)
    @boutonFinMenuPrincipal.set_size_request(-1, 30)
    @boutonEnregistrerGrille.set_size_request(-1, 30)
    
    @texteGagne = Gtk::Label.new("")
    
    @vBoxDroiteFin = Gtk::VBox.new(false, 0)
    
    @vBoxDroiteFin.pack_start(@texteGagne, false, false, 20)
    @vBoxDroiteFin.pack_start(@boutonNouvellePartie, false, false, 10)
    @vBoxDroiteFin.pack_start(@boutonEnregistrerGrille, false, false, 10)
    @vBoxDroiteFin.pack_end(@boutonFinMenuPrincipal, false, false, 10)
    
    
    ################################################################
    #                                                              #
    #                 Finalisation de la fenêtre                   #
    #                                                              #
    ###############################################################
    
    
    @vBoxDroite = Gtk::VBox.new(true, 0)
    @hBoxPrincipale = Gtk::HBox.new(false, 5)
    
    @vBoxDroite.set_border_width(5)
    @hBoxPrincipale.set_border_width(5)
    
    @vBoxDroite.pack_start(@hBoxTemps, false, false, 30)
    @vBoxDroite.pack_start(@alignePause, false, false, 30)
    @vBoxDroite.pack_end(@boutonAide, false, false, 30)
    @vBoxDroite.pack_start(@vBoxDroiteFin, false, false, 0)
    
    
    @hBoxPrincipale.pack_start(@vBoxPause, true, false, 40)  # DEBUG
    @hBoxPrincipale.pack_start(@tableauGeneral, true, true, 0)
    @hBoxPrincipale.pack_end(@vBoxDroite, false, false, 10)
    @hBoxPrincipale.pack_end(Gtk::VSeparator.new(), false, false, 0)
    
    @fenetre.add(@hBoxPrincipale)
    
  end
  
  
  
  ################################################################
  #                                                              #
  #                           Méthodes                           #
  #                                                              #
  ################################################################
  
  
  def grandesConditions
    
    @aligneConditionsV.set_padding(0, 0, 10, 0)
    @tableauConditionsV.set_column_spacings(25)
    
    @aligneConditionsH.set_padding(10, 0, 0, 0)
    @tableauConditionsH.set_row_spacings(19)
  end
  
  def petitesConditions
  
    @aligneConditionsV.set_padding(0, 0, 5, 0)
    
    if Gtk::VERSION.to_s == "[2, 24, 22]" then
      
      @tableauConditionsV.set_column_spacings(10)
      @tableauConditionsH.set_row_spacings(7)
      
    else
      
      @tableauConditionsV.set_column_spacings(15)
      @tableauConditionsH.set_row_spacings(9.3)
    
    end
    
    @aligneConditionsH.set_padding(5, 0, 0, 0)
    
  end
  
  def nomSauvegardeDefaut(nomParDefaut)
    
    @entreeSauvegarde.set_text(nomParDefaut)
  end
  
  def affichagePauseProfil()
    
    puts "> Pause Profil"
    @fenetre.set_title("Pause...")
    @boutonPause.set_image(imageLecture)
    @texteTemps.set_text("Temps écoulé :\n(Pause)")
    
    @tableauGeneral.hide_all()   
    @vBoxPause.show_all()
    @texteInfosSauvegarde.hide_all()
    @texteInfosNettoyer.hide_all()
    
    @entreeSauvegarde.set_focus(true)
  end
  
  def affichagePauseSimple()
    
    puts "> Pause Simple"
    @fenetre.set_title("Pause...")
    @boutonPause.set_image(imageLecture)
    @texteTemps.set_text("Temps écoulé :\n(Pause)")
    
    @tableauGeneral.hide_all()   
    @vBoxPause.show_all()
    @vBoxSauvegarde.hide_all()
    @texteInfosNettoyer.hide_all()
  end
  
  def affichageJeu()
    
    puts "> Lecture"
    @fenetre.set_title("Jouez !")
    @boutonPause.set_image(imagePause)
    @texteTemps.set_text("Temps écoulé :")
    
    @vBoxPause.hide_all()
    @tableauGeneral.show_all()
  end
  
  def affichageDepart()
    
    puts "> Démarrage du jeu"
    
    @vBoxPause.hide_all()
    @texteGagne.hide_all()
    @boutonNouvellePartie.hide_all()
    @boutonFinMenuPrincipal.hide_all()
    @boutonEnregistrerGrille.hide_all()
  end
  
  def affichageFin(temps)
    
    score = temps * 3
    
    @aligneConditionsV.hide_all()
    @aligneConditionsH.hide_all()
    
    @hBoxTemps.hide_all()
    @alignePause.hide_all()
    @boutonAide.hide_all()
    
    @texteGagne.set_text(
    "Félicitation !\n
    Vous avez gagné !\n
    Temps: " + @minutes.to_s + " minutes et " + @secondes.to_s + " secondes
    Score: " + score.to_s + "\n
    Êtes-vous prêt à retenter l'expérience ?")
    
    @texteGagne.show_all()
    @boutonNouvellePartie.show_all()
    @boutonEnregistrerGrille.show_all()
    @boutonFinMenuPrincipal.show_all()
  end
  
  def actualiserTemps()
      
    @afficheTemps.set_text(@minutes.to_s + ":" + @secondes.to_s)
  end
  
end






















