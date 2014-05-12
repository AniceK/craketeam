# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'
require './Modele/Jeu'
require './Controleur/EventsAccueil'



  ##################################################################
  #                           Exécution                            #
  ##################################################################

  # Classe permettant de lancer le jeu en créant le premier ensemble d'évènements liés à la fenêtre d'accueil
class NouveauJeu
    
  # Contient l'ensemble d'évènements à attendre de l'interface graphique actuelle
  @evenements
  # Contient la position de la première fenêtre à afficher qui sera donc en centre de l'écran
  @positionFenetreDemarrage

  # Accessible et modifiable par d'autres classes
  attr_accessor :evenements
  
  # Ne peut pas être instancié
  private_class_method :new

  ### Initialisation des évènements et donc du moteur et de l'interface gtk ###
  def initialize()
    
    verbose = false
    
    puts "Lancement du programme"
    
    jeu = Jeu.creer(verbose)

    # Préparation de l'interface Gtk
    Gtk.init
  
    # Création du premier ensemble d'évènements et de la première fenêtre
    @evenements = EventsAccueil.new(jeu, Gtk::Window::POS_CENTER)

    # Lancement du programme lié aux évènements
    Gtk.main
  
    puts "Fin du programme"
  end
  
  ### Permet d'obtenir une instance du jeu sans appeler directement la méthode new qui est privée ###
  def NouveauJeu.lancer()
    
    # Appel de la méthode new autorisé
    new
  end
  
  # Lance une instance de jeu
  nouveauJeu = NouveauJeu.lancer()
  
end