# encoding: utf-8
#! /usr/bin/env ruby
##
#25/02/2014
#Projet Picross equipe CrakeTeam
#
#Ce fichier contient la classe Grille, qui est constituee de Case
#ici une description de la classe Grille.

require_relative "Rangee.rb"
require 'fileutils'

class Grille

    @colonne
    @ligne
    @grille
    @createur
    @taille
    @nom
    @date

    attr_reader :colonne, :ligne, :grille, :createur, :taille, :nom, :date

	# Constructeur de la classe Grille

    def Grille.creer(nom, taille)
    
        new(nom, taille)

    end

    def initialize(nom, taille)

        @taille = taille
        @date = Time.now()
        @colonne = Array.new(taille)
        @ligne = Array.new(taille)
        @grille = Array.new(taille)
        @createur = nom

        for i in (0 .. taille-1)

            @colonne[i] = Rangee.creer(taille)
            @ligne[i] = Rangee.creer(taille)
            @grille[i] = Array.new(taille)
            
            for j in (0 .. taille-1)

                @grille[i][j] = Case.creer()
            end
        end

    end


# Méthode renvoyant la taille de la grille
    def getTaille()

        return @taille
    end

	# Méthode vérifiant la validité du coup joué

    def verifierCoup(coordX, coordY)

      @colonne[coordX].verifier()
      @ligne[coordY].verifier()

    end

	# Méthode vérifiant si la partie est terminée, en passant en revue la validité de chacune des Rangées

    def termine?()

      res = true
      @colonne.each { |x|
          
          if x.valide() == false then
              res = false
          end
      }
      @ligne.each { |x|
          
          if x.valide() == false then
              res = false
          end
      }
      return res

    end

# Méthode permettant de noircir une Case à partir de ses coordonnées
	def noircir(coordX, coordY)

	    @colonne[coordX].noircir(coordY)
	    @ligne[coordY].noircir(coordX)
        @grille[coordY].at(coordX).noircir()

	end

# Méthode pour remettre la grille à zéro : cela implique uniquement les tableaux de cases, et non pas ceux de conditions
  def raz()
    
    @colonne.each { |x|
      
      x.razCases()
    }
    
    @ligne.each { |x|
    
      x.razCases()
    }
    
    @grille.each { |x|
    
      x.each { |y|
      
        y.raz()
      }
    }
  end

# Méthode permettant de déterminer les conditions de remplissage de la grille à partir des cases noircies
	def conditionsDeterminer()

		@colonne.each { |x|

			x.conditionsDeterminer()

		}

		@ligne.each { |x|

			x.conditionsDeterminer()

		}

	end

# Méthode permettant de marquer une Case comme n'étant pas à cocher à partir de ses coordonnées

	def marquerCase(coordX, coordY)

	    @colonne[coordX].marquer(coordY)
	    @ligne[coordY].marquer(coordX)
        @grille[coordY][coordX].marquer()

    end
    
# Méthode de génération aléatoire d'une grille, noircissant au hasard des cases, déterminant les conditions et remettant la grille à 0   
    def genererAleatoire(unCoef)

        #remise à zéro des rangées
        @ligne.each { |x|
            
            x.razCases()
        }
        
        @colonne.each { |x| 
            
            x.razCases()
        }

        #on noircit des cases au hasard
        for i in (0..@taille-1)
      
            for j in (0..@taille-1)
          
                alea = 0 + Random.rand(100)
          
                if (alea > unCoef) then
              
                    @colonne[i].noircir(j)
                    @ligne[j].noircir(i)
                end
            end
        end

        #la grille remplit les conditions de chaque ligne et colonne.
	    self.conditionsDeterminer()

        #on remet la grille à zéro (les cases uniquement, pas les conditions)
        self.raz()

    end
    
# Méthode de sérialisation de la grille, avec remise à zéro préalable des tableaux de cases des Rangées
    def sauvegarder(unNom)

        self.raz()
        @nom = unNom

        FileUtils.cd('Grille')
        FileUtils.cd(@taille.to_s())
        tab = Array.new()

        if File.size('grilles.yml') != 0 then
        
            tab = Array.new(YAML::load(File.open('grilles.yml')))
            tabnom = Array.new()
            tab.each { |x|
                tabnom.push(x[0])
            }
            if tabnom.inculde?(unNom) then

                return false
            end
        end
        tab.push([@nom, @date,self])
        File.delete('grilles.yml')
        File.open('grilles.yml',"w"){|out| out.puts tab.to_yaml()}
        FileUtils.cd('../..')
        return true
    end
  
  
# Méthode d'affichage reservee aux tests, affichage uniquement des colonnes
    def afficher()

        @colonne.each { |x|
            
            x.afficher()
        }
    end

# Méthode pour retourner le nombre de conditions dans la colonne x passe en parametre
    def nbConditionsV(x)

            return @colonne[x].nbConditions()
    end

# Méthode pour retourner le nombre de conditions dans la ligne passe en parametre
    def nbConditionsH(x)

            return @ligne[x].nbConditions()
    end

# Méthode pour retourner la condition y dans la colonne x passe en parametre
    def conditionV(x, y)

            return @colonne[x].condition(y)
    end

# Méthode pour retourner la condition y dans la ligne x passe en parametre
    def conditionH(x, y)

            return @ligne[x].condition(y)
    end

end
