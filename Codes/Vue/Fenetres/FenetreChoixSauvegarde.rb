# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreChoixSauvegarde < Fenetre
  
  @boutonPrecedent
  @boutonSuivant
  @texteChoixSauvegarde
  
  attr_reader :boutonPrecedent,
              :boutonSuivant,
              :texteChoixSauvegarde
  
  public_class_method :new
  
  def initialize()
    super()
    
    @fenetre.set_title("ChoixSauvegarde")
    
    #==================================================#
    #               Déclaration éléments               #
    #==================================================#
    
    @texteChoixSauvegarde = Gtk::Label.new("Choisissez votre sauvegarde")
    
    @boutonPrecedent = Gtk::Button.new('Précédent')
    @boutonSuivant = Gtk::Button.new('Suivant')
    
    #==================================================#
    #               Paramètrage éléments               #
    #==================================================#
    
    @boutonPrecedent.set_size_request(-1, 50)
    @boutonSuivant.set_size_request(-1, 50)
    
    #==================================================#
    #                  Déclaration Box                 #
    #==================================================#
    
    hBoxNavigation = Gtk::HBox.new(true, 0)
    vBox = Gtk::VBox.new(false, 0)
    
    #==================================================#
    #                 Paramètrage Box                  #
    #==================================================#
    
    vBox.set_border_width(5)
    hBoxNavigation.set_border_width(5)
    
    #==================================================#
    #                  Remplissage Box                 #
    #==================================================#
    
    hBoxNavigation.pack_start(@boutonPrecedent)
    hBoxNavigation.pack_end(@boutonSuivant)
    
    vBox.pack_start(@texteChoixSauvegarde, true, true, 30)
    vBox.pack_end(hBoxNavigation, false, true, 0)
    
    #==================================================#
    #                Ajout à la fenêtre                #
    #==================================================#
    
    @fenetre.add(vBox)
  end
  
end











