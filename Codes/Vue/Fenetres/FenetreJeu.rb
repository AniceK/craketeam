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
  @boutonMenu
  
  attr_reader :texteTemps, :boutonAide, :boutonMenu
  attr_accessor :tableauConditionsV, :tableauConditionsH, :tableauJeu, :tempsEcoule
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Jouez !")
    
    @texteTemps = Gtk::Label.new("Temps écoulé :")
    @tempsEcoule = Gtk::Label.new("0")
    @boutonAide = Gtk::Button.new('Aide')
    @boutonMenu = Gtk::Button.new('Menu')
    @tableauGeneral = Gtk::Table.new(0, 0, false)
    @tableauConditionsV = Gtk::Table.new(0, 0, false)
    @tableauConditionsH = Gtk::Table.new(0, 0, false)
    @tableauJeu = Gtk::Table.new(0, 0, false)
    
    @boutonAide.set_size_request(80, 30)
    @boutonMenu.set_size_request(80, 30)
    @tableauGeneral.attach_defaults(@tableauConditionsV, 1, 2, 0, 1)
    @tableauGeneral.attach_defaults(@tableauConditionsH, 0, 1, 1, 2)
    @tableauGeneral.attach_defaults(@tableauJeu, 1, 2, 1, 2)
    
    hBoxTemps = Gtk::HBox.new(true, 0)
    hBoxBoutons = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)
    
    hBoxTemps.set_border_width(5)
    hBoxBoutons.set_border_width(5)
    vBox.set_border_width(5)
    
    hBoxTemps.pack_start(@texteTemps, false, false, 0)
    hBoxTemps.pack_start(@tempsEcoule, false, false, 0)
    
    hBoxBoutons.pack_start(@boutonAide, false, false, 0)
    hBoxBoutons.pack_start(@boutonMenu, false, false, 0)
    
    vBox.pack_start(hBoxTemps, false, false, 10)
    vBox.pack_start(Gtk::HSeparator.new(), false, false, 0)
    vBox.pack_start(@tableauGeneral, false, false, 0)
    vBox.pack_start(Gtk::HSeparator.new(), false, false, 0)
    vBox.pack_start(hBoxBoutons, false, false, 10)
    
    @fenetre.add(vBox)
  end
  
end











