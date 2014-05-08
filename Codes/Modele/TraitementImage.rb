# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#
# Test du traitement d'image  

require "RMagick"
include Magick

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
  
  #On transforme l'image en en soit Blanc ou noir
  def traitementMonochrome()
    return @image = @image.quantize(2, GRAYColorspace)
  end
  
  #Pixelise l'image dans la taille souhaité
  def traitementPixel(taille)
    return @image.resize_to_fit!(taille)
  end
  
  #Transforme l'image noir et blanc en picross Noir et blanc
  #On compare la couleur au vert
  #Si c'est une couleur, alors c'est noir, sinon c'est blanc
  def imageToPicross(taille)
  		@grille = Array.new(taille) { Array.new(taille) }

  		0.upto(taille - 1){|y|
  			0.upto(taille - 1){|x|
  				@grille[x][y] = (@image.pixel_color(x,y).green == 0 ? 1:0)
  			}
  		}
  		return grille
  end
  
  #Pour une image en noir et blanc, on pixelise, et monochrome
  #On retourne ensuite la grille
  def routine(taille)
    self.traitementPixel(taille)
    self.traitementMonochrome()
    
    return @grille = self.imageToPicross(taille)
  end
  
  #Affichage de test
  def afficherGrille
    texte = ""
    		0.upto(@grille.size-1){ |y|
    			0.upto(@grille.size-1){ |x|
    				texte += @grille[x][y].to_s
    			}
    			texte += "\n"
    		}
    		return texte
  end
    
end





    
  
  