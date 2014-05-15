# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreOptions < Fenetre


  @boutonReinitialiser
  @boutonAfficherScores
  @texteInfos
  @boutonPrecedent
  
  attr_reader :boutonReinitialiser,
              :boutonAfficherScores,
              :texteInfos,
              :boutonPrecedent
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Options")
    
    @boutonReinitialiser = Gtk::Button.new('Réinitialiser')
    @boutonAfficherScores = Gtk::Button.new('High Score')
    @texteInfos = Gtk::Label.new("")
    @boutonPrecedent = Gtk::Button.new('Précédent')
    
    @boutonReinitialiser.set_size_request(-1, 50)
    @boutonAfficherScores.set_size_request(-1, 50)
    @boutonPrecedent.set_size_request(-1, 50)
    
    vBox = Gtk::VBox.new(false, 0)
    
    vBox.set_border_width(5)
    
    vBox.pack_start(@boutonReinitialiser, false, false, 10)
    vBox.pack_start(@boutonAfficherScores, false, false, 10)
    vBox.pack_end(@boutonPrecedent, false, true, 5)
    vBox.pack_end(@texteInfos, false, true, 5)
    
    @fenetre.add(vBox)
  end
  
  def affichageSimple()
    
    @boutonReinitialiser.hide_all()
    @texteInfos.hide_all()
  end
  
  def affichageProfil()
    
    @texteInfos.hide_all()
    @boutonReinitialiser.show_all()
  end
  
  def affichageInfos(message)
    
    @texteInfos.set_markup("<span foreground='red'>" + message + "</span>")
    @texteInfos.show_all()
  end
  
end











