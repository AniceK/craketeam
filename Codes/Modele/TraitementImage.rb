# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#
# Test du traitement d'image  

require "RMagick"
include Magick

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

class TraitementImage #Voir test4 pour test
  
  @image
  @grille
  
  attr_reader :image, :grille
  
  def TraitementImage.lire(entree)
    new(entree)
  end
  
  def initialize(entree)
    @image = ImageList.new(entree)
  end
  
  def enregistrer(sortie)
    @image.write(sortie)
  end
  
  def traitementMonochrome()
    return @image = @image.quantize(2, GRAYColorspace)
  end
  
  def traitementPixel(taille)
    return @image.resize_to_fit!(taille)
  end
  
  def imageToPicross(taille)
  		@grille = Array.new(taille) { Array.new(taille) }

  		0.upto(taille - 1){|y|
  			0.upto(taille - 1){|x|
  				@grille[x][y] = (@image.pixel_color(x,y).red == 0 ? 1:0)
  			}
  		}
  		return grille
  end
  
  def afficherGrille
  		texte = ""
  		0.upto(@grille.size-1){ |y|
  			0.upto(@grille.size-1){ |x|
  				texte += @grille[x][y].to_s
  			}
  			texte += "\n"
  		}
  		puts texte
  	end
    
end





    
  
  