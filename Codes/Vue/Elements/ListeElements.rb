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
  @selection
  
  attr_reader :listeDeroulante,
              :selection
  
  def initialize(liste)
    
    affichage = Gtk::TreeView.new()
    modele = Gtk::ListStore.new(Integer, String, String)
    @listeDeroulante = Gtk::ScrolledWindow.new()
    
    parametrerAffichage(affichage, modele)
    
    liste.each_with_index do |e, i|
      
      reference = modele.append
    
       modele.set_value(reference, TAILLE, liste[i][0])
       modele.set_value(reference, NOM, liste[i][1])
       modele.set_value(reference, DATE, liste[i][2].asctime())
      
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
    
    colonneTaille = Gtk::TreeViewColumn.new("Taille", rendreRouge,  :text => TAILLE)
    colonneNom = Gtk::TreeViewColumn.new("Nom", rendreNoir, :text => NOM)
    colonneDate = Gtk::TreeViewColumn.new("Date", rendreNoir, :text => DATE)
    
    self.triable(colonneTaille, TAILLE)
    self.triable(colonneNom, NOM)
    self.triable(colonneDate, DATE)
    
    affichage.append_column(colonneTaille)
    affichage.append_column(colonneNom)
    affichage.append_column(colonneDate)
  end
  
  
  def widget()
    
    return @listeDeroulante
    
  end
  
  
  def selectionCourante()
    
    return @selection = widget.child.selection.selected[1]
  end
  
end














