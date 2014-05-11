# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

TAILLE = 0;
NOM = 1;
DATE  = 2;

class ListeElements
  
  @listeDeroulante
  
  attr_reader :listeDeroulante
  
  def initialize(liste)
    
    affichage = Gtk::TreeView.new()
    modele = Gtk::ListStore.new(Integer, String, String)
    @listeDeroulante = Gtk::ScrolledWindow.new()
    
    parametrerAffichage(affichage, modele)
    
    liste.each_with_index do |e, i|
      
      reference = modele.append
    
      modele.set_value(reference, TAILLE, liste[i].taille)
      modele.set_value(reference, NOM, liste[i].nom)
      modele.set_value(reference, DATE, liste[i].date)
    end
    
    affichage.model = modele
    
    @listeDeroulante.add(affichage)
    @listeDeroulante.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
    
  end

  
  def triable(colonne, colonne_id)
    
    colonne.sort_indicator = true
    colonne.sort_column_id = colonne_id

    colonne.signal_connect('clicked') do |w|
      
        puts "> Ordre colonne " + colonne.title() + " inversé"
        w.sort_order == Gtk::SORT_ASCENDING ? Gtk::SORT_DESCENDING : Gtk::SORT_ASCENDING
    end
    
  end

  def parametrerAffichage(affichage, modele)
    
    rendreRouge = Gtk::CellRendererText.new
    rendreRouge.foreground = "#ff0000"
    
    rendreNoir = Gtk::CellRendererText.new()
    
    column = Gtk::TreeViewColumn.new("Taille", rendreRouge,  :text => TAILLE)
    self.triable(column, TAILLE)
    affichage.append_column(column)
    
    column = Gtk::TreeViewColumn.new("Nom", rendreNoir, :text => NOM)
    self.triable(column, NOM)
    affichage.append_column(column)
    
    column = Gtk::TreeViewColumn.new("Date", rendreNoir, :text => DATE)
    self.triable(column, DATE)
    affichage.append_column(column)
  end
  
  
  def widget()
    
    return @listeDeroulante
    
  end
  
end














