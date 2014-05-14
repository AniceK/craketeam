# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreOptions < Fenetre
  
  @boutonViderGrilles
  @boutonViderSauvegardes
  @boutonPrecedent
  
  attr_reader :boutonViderGrilles,
              :boutonViderSauvegardes,
              :boutonPrecedent
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Options")
    
    @boutonViderGrilles = Gtk::Button.new('Réinitialiser Créations')
    @boutonViderSauvegardes = Gtk::Button.new('Réinitialiser Sauvegarde')
    
    @boutonViderGrilles.set_size_request(-1, 40)
    @boutonViderSauvegardes.set_size_request(-1, 40)
    
    @boutonPrecedent = Gtk::Button.new('Précédent')
    
    @boutonPrecedent.set_size_request(-1, 50)
    
    hBoxVider = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)
    
    hBoxVider.set_border_width(5)
    vBox.set_border_width(5)
    
    hBoxVider.pack_start(@boutonViderGrilles, false, false, 0)
    hBoxVider.pack_start(@boutonViderSauvegardes, false, false, 0)
    
    vBox.pack_start(hBoxVider, true, false, 10)
    vBox.pack_end(@boutonPrecedent, false, true, 0)
    
    @fenetre.add(vBox)
  end
  
end











