# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreReinitialiser < Fenetre
  
  @texteInfos
  @boutonViderGrilles
  @boutonViderSauvegardes
  @boutonViderTout
  @boutonPrecedent
  
  attr_reader :texteInfos,
              :boutonViderGrilles,
              :boutonViderSauvegardes,
              :boutonViderTout,
              :boutonPrecedent,
              :viderTout
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Options")
    
    @texteInfos = Gtk::Label.new("")
    
    @boutonViderGrilles = Gtk::Button.new('Réinitialiser Créations')
    @boutonViderSauvegardes = Gtk::Button.new('Réinitialiser Sauvegarde')
    @boutonViderTout = Gtk::Button.new('Réinitialisation totale')
    
    @boutonViderGrilles.set_size_request(50, 40)
    @boutonViderSauvegardes.set_size_request(50, 40)
    @boutonViderTout.set_size_request(50, 40)
    
    @boutonPrecedent = Gtk::Button.new('Précédent')
    
    @boutonPrecedent.set_size_request(-1, 50)
    
    vBox = Gtk::VBox.new(false, 0)
    
    vBox.set_border_width(5)
    
    vBox.pack_start(@boutonViderGrilles, false, false, 5)
    vBox.pack_start(@boutonViderSauvegardes, false, false, 5)
    vBox.pack_start(@boutonViderTout, false, false, 5)
    vBox.pack_end(@boutonPrecedent, false, true, 0)
    vBox.pack_end(@texteInfos, false, false, 10)
    
    @fenetre.add(vBox)
  end
  
  def affichageDepart()
    
    @texteInfos.hide_all()
  end
  
  def affichageInfos(message)
    
    @texteInfos.set_markup("<span foreground='red'>" + message + "</span>")
    @texteInfos.show_all()
  end
  
end











