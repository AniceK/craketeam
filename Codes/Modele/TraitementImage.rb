# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#
# Test du traitement d'image  

#require "RMagick"
#include Magick

=begin
class RGBColour
  def to_grayscale
    luminosity = Integer(0.2126*@red + 0.7152*@green + 0.0722*@blue)
    self.class.new(luminosity, luminosity, luminosity)
  end
end
 
class Pixmap
  def to_grayscale
    gray = self.class.new(@width, @height)
    @width.times do |x|
      @height.times do |y|
        gray[x,y] = self[x,y].to_grayscale
      end
    end
    gray
  end
end
=end
=begin
class TraitementImage #Voir test4 pour test
  
  @image
  @grille
  
  attr_reader :image, :grille
  
  def traitementImage.lire(entree)
    new(entree)
  end
  
  def initialize(entree)
    @image = ImageList.new(entree)
  end
  
  def traitementMonochrome()
    return @image = @image.quantize(2, GRAYColorspace)
  end
  
  def traitementPixel(taille)
    return @image.rezise_to_fit!(taille)
  end
  
  def traitementToPricross(taille)
  
  end
end
=end
require ”imlib2”

img = load(”chat.jpg”)
result = new(img.width, img.height)

for col in (0...img.width) do 
  for row in (0...img.height) do
    gris = 0.3 * img.pixel(col , row).red + 0.59 * img.pixel(col , row).blue + 0.11 * img.pixel(col, row).green

    result.draw pixel( col, row, new( gris , gris , gris ,255) )
  end 
end

result.save(”chat gris.jpg”)


    
  
  