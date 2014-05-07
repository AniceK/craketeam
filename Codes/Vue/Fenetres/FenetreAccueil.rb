# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreAccueil < Fenetre
  
  @imageBanniere
  @boutonPartieRapide
  @boutonProfil
  @boutonOptions
  @boutonCredits
  @boutonQuitter
  
  attr_reader :imageBanniere, :boutonPartieRapide, :boutonProfil, :boutonOptions, :boutonCredits, :boutonQuitter
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Accueil")
    
    @boutonPartieRapide = Gtk::Button.new('Partie Rapide')
    @boutonProfil = Gtk::Button.new('Profil')
    @boutonOptions = Gtk::Button.new('Options')
    @boutonCredits = Gtk::Button.new('Credits')
    @boutonQuitter = Gtk::Button.new('Quitter')
    @imageBanniere = Gtk::Image.new('./Vue/Images/banniere.jpg')
    
    vBox = Gtk::VBox.new(false, 0)
    vBox.set_border_width(5)
    
    vBox.pack_start(@imageBanniere, true, true, 5)
    vBox.pack_start(@boutonPartieRapide, true, true, 0)
    vBox.pack_start(@boutonProfil, true, true, 0)
    vBox.pack_start(@boutonOptions, true, true, 0)
    vBox.pack_start(@boutonCredits, true, true, 0)
    vBox.pack_start(@boutonQuitter, true, true, 0)
    
    @fenetre.add(vBox)
  end
  
end











