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
  @image
  
  attr_reader :coordonneeX,
              :coordonneeY,
              :image,
              :etat
  
  def initialize(x, y, etat)
    
    super()
    
    @coordonneeX = x
    @coordonneeY = y
    
    @etat = etat
    
    @image = Gtk::Image.new(@etat)
    
    self.add(@image)
    
    #self.events = Gdk::Event::BUTTON_PRESS_MASK
    
  end
  
  def etatCourant()
    
    return @etat
  end
  
  def changerEtat(etat)
    
    @etat = etat
    @image.set_pixbuf(@etat)
  end
  
end














