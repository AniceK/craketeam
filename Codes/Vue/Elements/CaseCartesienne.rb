# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#


class CaseCartesienne < Gtk::EventBox
  
  @coordonneeX
  @coordonneeY
  @etat
  @signalID
  @image
  
  attr_reader :coordonneeX,
              :coordonneeY,
              :image,
              :etat,
              :signalID
  
  def initialize(x, y, etat)
    
    super()
    
    @coordonneeX = x
    @coordonneeY = y
    
    @etat = etat
    
    @image = Gtk::Image.new(@etat)
    
    self.add(@image)
    
  end
  
  def etatCourant()
    
    return @etat
  end
  
  def changerEtat(etat)
    
    @etat = etat
    @image.set_pixbuf(@etat)
  end
  
  def ajouterSignalID(id)
    
    @signalID = id
  end
  
  def recupererSignalID()
    
    return @signalID
  end
  
  #  def reagitClic()
  #    
  #    if self.events == Gdk::Event::BUTTON_PRESS_MASK then puts "Masque bouton appuyé" end
  #      
  #    self.set_events(Gdk::Event::BUTTON_PRESS_MASK)
  #    self.realize()
  #    
  #    if self.events == Gdk::Event::BUTTON_PRESS_MASK then puts "Masque bouton appuyé" end
  #  end
  #  
  #  def reagitSurvoler()
  #    
  #    self.add_events(Gdk::Event::BUTTON_RELEASE_MASK && Gdk::Event::ENTER_NOTIFY_MASK)
  #  end
  
end














