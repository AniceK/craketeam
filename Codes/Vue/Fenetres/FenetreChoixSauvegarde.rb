# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreChoixSauvegarde < Fenetre
  
  @boutonPrecedent
  @texteChoixSauvegarde
  
  attr_reader :boutonPrecedent, :texteChoixSauvegarde
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("ChoixSauvegarde")
    
    @boutonPrecedent = Gtk::Button.new('Précédent')
    @boutonPrecedent.set_size_request(-1, 50)
    
    @texteChoixSauvegarde = Gtk::Label.new("Remerciements:\n
                     Chef de projet - Tremblain Rémi
                     Documentaliste - Picard Colas
                     Documentaliste - Crouillère Kévin
                     Responsable de communication - Khomany Anice
                     Ingénieur Informatique - Marchand Erwan")
    
    vBox = Gtk::VBox.new(false, 0)
    vBox.set_border_width(5)
    
    vBox.pack_start(@texteChoixSauvegarde, true, true, 30)
    vBox.pack_end(@boutonPrecedent, false, true, 0)
    
    @fenetre.add(vBox)
  end
  
end











