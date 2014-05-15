# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'
require './Vue/Elements/ListeElements'

class FenetreChoixCreation < Fenetre
  
  @texteChoixCreation
  @boutonPrecedent
  @boutonSuivant
  @listeCreation
  @texteAucuneCreationSelectionnee
  
  
  attr_reader :boutonPrecedent,
              :boutonSuivant,
              :texteChoixCreation,
              :listeCreation,
              :texteAucuneCreationSelectionnee
  
  public_class_method :new
  
  def initialize(listeCreations)
    super()
    
    @fenetre.set_title("ChoixCreation")
    
    #==================================================#
    #           Déclaration / Initialisation           #
    #==================================================#
    
    @texteChoixCreation = Gtk::Label.new("Choisissez votre creation")
    
    @texteAucuneCreationSelectionnee = Gtk::Label.new.set_markup("<span foreground='red'>Veuillez sélectionner une création</span>")
    
    @boutonPrecedent = Gtk::Button.new('Précédent')
    @boutonSuivant = Gtk::Button.new('Suivant')
    
    @listeCreations = ListeElements.new(listeCreations, false)
    
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
    
    vBox.pack_start(@texteChoixCreation, false, false, 5)
    vBox.pack_start(@listeCreations.widget(), true, true, 5)
    vBox.pack_start(@texteAucuneCreationSelectionnee, false, false, 2)
    vBox.pack_end(hBoxNavigation, false, true, 0)
    
    #==================================================#
    #                Ajout à la fenêtre                #
    #==================================================#
    
    @fenetre.add(vBox)
  end
  
  def choixCreation()
    
    if (selection = @listeCreations.selectionCourante() ) != nil then
    
      return selection
      
    elsif @listeCreations.selectionCourante() == nil
      
      return nil
      
    else
      
      puts "[FenetreChoixCreation]Erreur: Problème dans le choix de création"
      
    end
    
  end
  
  def affichageDepart()
    
    @texteAucuneCreationSelectionnee.hide_all()
  end
  
  def affichageAucuneCreationSelectionnee
    
    @texteAucuneCreationSelectionnee.show_all()
  end
  
end











