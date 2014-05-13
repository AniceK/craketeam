# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreJeu < Fenetre
  
  @texteTemps
  @minutes
  @secondes
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
  @vBoxPause
  
  @texteGagne
  @boutonNouvellePartie
  @boutonFinMenuPrincipal
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
              :vBoxPause,
              
              :boutonNouvellePartie,
              :texteGagne,
              :boutonFinMenuPrincipal,
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
    
    
    @boutonPauseMenuPrincipal = Gtk::Button.new("Menu Principal")
    texteSauvegarde = Gtk::Label.new("Nom de la sauvegarde :")
    @entreeSauvegarde = Gtk::Entry.new()
    @boutonSauvegarder = Gtk::Button.new("Sauvegarder")
    @vBoxSauvegarde = Gtk::VBox.new(true, 0)
    @vBoxPause = Gtk::VBox.new(true, 0)
    
    @boutonPauseMenuPrincipal.set_size_request(-1, 50)
    @entreeSauvegarde.set_max_length(30)
    @entreeSauvegarde.set_text("save_")
    @boutonSauvegarder.set_size_request(-1, 50)
    
    @vBoxSauvegarde.pack_start(texteSauvegarde, false, false, 0)
    @vBoxSauvegarde.pack_start(@entreeSauvegarde, false, false, 0)
    @vBoxSauvegarde.pack_start(@boutonSauvegarder, false, false, 0)
    @vBoxPause.pack_start(@vBoxSauvegarde, false, false, 0)
    @vBoxPause.pack_start(@boutonPauseMenuPrincipal, false, false, 0)
    
    
    
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
    
    
    @fenetre.set_title("Jouez !")
    
    @afficheTemps =  Gtk::Label.new("")
    @boutonAide = Gtk::Button.new('Aide')
    @boutonPause = Gtk::Button.new()
    @tableauGeneral = Gtk::Table.new(0, 0, false)
    @tableauConditionsV = Gtk::Table.new(0, 0, true)
    @tableauConditionsH = Gtk::Table.new(0, 0, true)
    @tableauJeu = Gtk::Table.new(0, 0, true)
    tableauDefile = Gtk::ScrolledWindow.new
    pixPause = Gdk::Pixbuf.new('../Vue/Images/pause.gif')
    @imagePause = Gtk::Image.new(pixPause)
    pixLecture = Gdk::Pixbuf.new('../Vue/Images/lecture.gif')
    @imageLecture = Gtk::Image.new(pixLecture)
    
    @boutonAide.set_size_request(80, 30)
  
    @boutonPause.set_image(imagePause)
    
    @tableauConditionsH.set_column_spacings(5)
    
    @tableauJeu.set_column_spacings(2)
    @tableauJeu.set_row_spacings(2)
    
    @alignePause = Gtk::Alignment.new(0.5,0,0,0)
    @alignePause.add(@boutonPause)
    
    @aligneConditionsH = Gtk::Alignment.new(1,0,0,1)
    #@aligneConditionsH.set_padding(12, 0, 0, 0)
    @aligneConditionsH.add(@tableauConditionsH)
    
    @aligneConditionsV = Gtk::Alignment.new(0,1,1,0)
    #@aligneConditionsV.set_padding(0, 0, 10, 0)
    @aligneConditionsV.add(@tableauConditionsV)
    
    @tableauGeneral.set_row_spacings(10)
    @tableauGeneral.set_column_spacings(10)
    
    @tableauGeneral.attach_defaults(@aligneConditionsV, 1, 2, 0, 1)
    @tableauGeneral.attach_defaults(@aligneConditionsH, 0, 1, 1, 2)
    @tableauGeneral.attach_defaults(@tableauJeu, 1, 2, 1, 2)
    
    @hBoxTemps = Gtk::HBox.new(true, 0)
    @vBoxDroite = Gtk::VBox.new(true, 0)
    @hBoxPrincipale = Gtk::HBox.new(false, 5)
    
    @hBoxTemps.set_border_width(5)
    @vBoxDroite.set_border_width(5)
    @hBoxPrincipale.set_border_width(5)
    
    @hBoxTemps.pack_start(@texteTemps, false, false, 0)
    @hBoxTemps.pack_start(@afficheTemps, false, false, 20)
    
    
    ################################################################
    #                                                              #
    #                        Partie Gagnée                         #
    #                                                              #
    ################################################################
    
    
    @boutonNouvellePartie = Gtk::Button.new('Nouvelle Partie')
    @boutonFinMenuPrincipal = Gtk::Button.new('Menu Principal')
    
    @boutonNouvellePartie.set_size_request(-1, 50)
    @boutonFinMenuPrincipal.set_size_request(-1, 50)
    
    @texteGagne = Gtk::Label.new("")
    
    
    ### Finalisation de la fenêtre
    
    @vBoxDroite.pack_start(@hBoxTemps, false, false, 30)
    @vBoxDroite.pack_start(@alignePause, false, false, 30)
    @vBoxDroite.pack_end(@boutonAide, false, false, 30)
    @vBoxDroite.pack_start(@texteGagne, false, false, 30)
    @vBoxDroite.pack_start(@boutonNouvellePartie, false, false, 40)
    @vBoxDroite.pack_end(@boutonFinMenuPrincipal, false, false, 0)
    
    
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
    
    #@aligneConditionsV.set_padding(0, 0, 40, 0)
    @tableauConditionsV.set_column_spacings(25)
    
    #@aligneConditionsH.set_padding(40, 0, 0, 0)
    @tableauConditionsH.set_row_spacings(19)
  end
  
  def petitesConditions
    
    #@aligneConditionsV.set_padding(0, 0, 27, 0)
    @tableauConditionsV.set_column_spacings(15)
    
   #@aligneConditionsH.set_padding(25, 0, 0, 0)
    @tableauConditionsH.set_row_spacings(9.3)
  end
  
  def affichagePauseProfil()
    
    puts "> Pause Profil"
    @fenetre.set_title("Pause...")
    @boutonPause.set_image(imageLecture)
    @texteTemps.set_text("Temps écoulé :\n(Pause)")
    
    @tableauGeneral.hide_all()   
    @vBoxPause.show_all()
  end
  
  def affichagePauseSimple()
    
    puts "> Pause Simple"
    @fenetre.set_title("Pause...")
    @boutonPause.set_image(imageLecture)
    @texteTemps.set_text("Temps écoulé :\n(Pause)")
    
    @tableauGeneral.hide_all()   
    @vBoxPause.show_all()
    @vBoxSauvegarde.hide_all()
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
    @boutonFinMenuPrincipal.show_all()
  end
  
  def actualiserTemps()
      
    @afficheTemps.set_text(@minutes.to_s + ":" + @secondes.to_s)
  end
  
end






















