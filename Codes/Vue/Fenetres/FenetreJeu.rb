# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreJeu < Fenetre
  
  @texteTemps
  @tempsEcoule
  @tableauGeneral
  @tableauConditionsV
  @tableauConditionsH
  @tableauJeu
  @boutonAide
  @boutonPause
  @imagePause
  @imageLecture
  
  attr_reader :texteTemps, :boutonAide, :boutonPause, :imagePause, :imageLecture
  attr_accessor :tableauConditionsV, :tableauConditionsH, :tableauJeu, :tempsEcoule
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Jouez !")
    
    #@menuPause = MenuPause.new()
    @menuPause = Gtk::Label.new("Menu de Pause")
    
    @texteTemps = Gtk::Label.new("Temps écoulé :")
    @tempsEcoule = Gtk::Label.new("0")
    @boutonAide = Gtk::Button.new('Aide')
    @boutonPause = Gtk::Button.new()
    @tableauGeneral = Gtk::Table.new(0, 0, false)
    @tableauConditionsV = Gtk::Table.new(0, 0, true)
    @tableauConditionsH = Gtk::Table.new(0, 0, true)
    @tableauJeu = Gtk::Table.new(0, 0, true)
    tableauDefile = Gtk::ScrolledWindow.new
    pixPause = Gdk::Pixbuf.new('./Vue/Images/pause.gif')
    @imagePause = Gtk::Image.new(pixPause)
    pixLecture = Gdk::Pixbuf.new('./Vue/Images/lecture.gif')
    @imageLecture = Gtk::Image.new(pixLecture)
    
    @boutonAide.set_size_request(80, 30)
  
    @boutonPause.set_image(imagePause)
    
    @tableauConditionsH.set_column_spacings(5)
    
    @tableauJeu.set_column_spacings(2)
    @tableauJeu.set_row_spacings(2)
    
    @alignePause = Gtk::Alignment.new(0.5,0,0,0)
    @alignePause.add(@boutonPause)
    
    @aligneConditionsH = Gtk::Alignment.new(1,0,0,1)
    @aligneConditionsH.set_padding(12, 0, 0, 0)
    @aligneConditionsH.add(@tableauConditionsH)
    
    @aligneConditionsV = Gtk::Alignment.new(0,1,1,0)
    @aligneConditionsV.set_padding(0, 0, 10, 0)
    @aligneConditionsV.add(@tableauConditionsV)
    
    @tableauGeneral.attach_defaults(@aligneConditionsV, 1, 2, 0, 1)
    @tableauGeneral.attach_defaults(@aligneConditionsH, 0, 1, 1, 2)
    @tableauGeneral.attach_defaults(@tableauJeu, 1, 2, 1, 2)
    
    hBoxTemps = Gtk::HBox.new(false, 0)
    vBoxDroite = Gtk::VBox.new(true, 0)
    @hBoxPrincipale = Gtk::HBox.new(false, 5)
    
    hBoxTemps.set_border_width(5)
    vBoxDroite.set_border_width(5)
    @hBoxPrincipale.set_border_width(5)
    
    hBoxTemps.pack_start(@texteTemps, false, false, 0)
    hBoxTemps.pack_start(@tempsEcoule, false, false, 20)
    
    vBoxDroite.pack_start(hBoxTemps, false, false, 30)
    vBoxDroite.pack_start(@alignePause, false, false, 30)
    vBoxDroite.pack_end(@boutonAide, false, false, 30)
    
    @hBoxPrincipale.pack_start(@menuPause, true, true, 0)  # DEBUG
    @hBoxPrincipale.pack_start(@tableauGeneral, true, true, 0)
    @hBoxPrincipale.pack_end(vBoxDroite, false, false, 10)
    @hBoxPrincipale.pack_end(Gtk::VSeparator.new(), false, false, 0)
    
    @fenetre.add(@hBoxPrincipale)
    
  end
  
  def grandesConditions
    
    @tableauConditionsV.set_column_spacings(25)
    @tableauConditionsH.set_row_spacings(19)
  end
  
  def petitesConditions
    
    @aligneConditionsH.set_padding(0, 0, 0, 0)
    @tableauConditionsV.set_column_spacings(15)
    
    @aligneConditionsH.set_padding(5, 0, 0, 0)
    @tableauConditionsH.set_row_spacings(9.3)
  end

  
  
  def affichagePause()
    
    puts "> Pause"
    @boutonPause.set_image(imageLecture)
    
    @tableauGeneral.hide_all()   
    @menuPause.show_all()
  end
  
  def affichageJeu()
    
    puts "> Lecture"
    @boutonPause.set_image(imagePause)
    
    @menuPause.hide_all()
    @tableauGeneral.show_all()
  end
  
end






















