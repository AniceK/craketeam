# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreOptions < Fenetre
  
  @texteLangue
  @comboBoxLangues
  @boutonPrecedent
  
  attr_reader :texteLangue, :comboBoxLangues, :boutonPrecedent
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("Options")
    
    @texteLangue = Gtk::Label.new("Langue :")
    @comboBoxLangues = Gtk::ComboBox.new()
    @boutonPrecedent = Gtk::Button.new('Précédent')
    
    @boutonPrecedent.set_size_request(-1, 50)
    
    hBox = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)
    
    hBox.set_border_width(5)
    vBox.set_border_width(5)
    
    hBox.pack_start(@texteLangue, true, true, 0)
    hBox.pack_start(@comboBoxLangues, false, false, 0)
    
    vBox.pack_start(hBox, true, false, 65)
    vBox.pack_start(@boutonPrecedent, false, true, 0)
    
    @fenetre.add(vBox)
  end
  
end











