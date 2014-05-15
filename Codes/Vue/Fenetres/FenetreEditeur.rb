# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require_relative 'Fenetre'

class FenetreEditeur < Fenetre

  @tableauJeu
  @boutonQuitter
  @boutonEnregistrer
  @vBoxDroite
  @hBoxPrincipale
  
  attr_reader :boutonQuitter,
              :boutonEnregistrer,
              :vBoxDroite,
              :afficheTemps,
              :hBoxPrincipale
              
  attr_accessor :tableauJeu
  
  public_class_method :new
  
  def initialize()
    super()  


    ################################################################
    #                                                              #
    #                             Jeu                              #
    #                                                              #
    ################################################################
    
    
    @fenetre.set_title("Éditer !")
    
    @boutonEnregistrer = Gtk::Button.new("Enregistrer")
    @boutonQuitter = Gtk::Button.new('Quitter')
    @tableauJeu = Gtk::Table.new(0, 0, true)
    
    @boutonEnregistrer.set_size_request(80, 30)
    @boutonQuitter.set_size_request(80, 30)
    
    @tableauJeu.set_column_spacings(2)
    @tableauJeu.set_row_spacings(2)
    
    aligneTableau = Gtk::Alignment.new(0.5, 0.5, 0, 0)
    aligneTableau.add(@tableauJeu)
    
    @vBoxDroite = Gtk::VBox.new(true, 0)
    @hBoxPrincipale = Gtk::HBox.new(false, 5)
    
    @vBoxDroite.set_border_width(5)
    @hBoxPrincipale.set_border_width(5)
    
    @vBoxDroite.pack_end(@boutonQuitter, false, false, 30)
    @vBoxDroite.pack_end(@boutonEnregistrer, false, false, 30)
    
    @hBoxPrincipale.pack_start(aligneTableau, true, true, 0)
    @hBoxPrincipale.pack_end(@vBoxDroite, false, false, 10)
    @hBoxPrincipale.pack_end(Gtk::VSeparator.new(), false, false, 0)
    
    @fenetre.add(@hBoxPrincipale)
    
  end
  
end






















