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

    attr_reader :colonne, :ligne, :grille, :createur

	# Constructeur de la classe Grille

    def Grille.creer(nom, taille)
    
        new(nom, taille)

    end

    def initialize(nom, taille)

        @taille = taille
        @colonne = Array.new(taille)
        @ligne = Array.new(taille)
        @grille = Array.new(taille, Array.new(taille, Case.creer()))
        @createur = nom

        for i in (0 .. taille-1)

            @colonne[i] = Rangee.creer(taille)
            @ligne[i] = Rangee.creer(taille)
        end

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
	def noircirCase(coordX, coordY)

	    @colonne[coordX].noircir(coordY)
	    @ligne[coordY].noircir(coordX)

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
              
                    self.noircirCase(i, j)
                end
            end
        end

        #la grille remplit les conditions de chaque ligne et colonne.
	    self.conditionsDeterminer()

        #on remet la grille à zéro (les cases uniquement, pas les conditions)
        self.raz()

    end
    
# Méthode de sérialisation de la grille, avec remise à zéro préalable des tableaux de cases des Rangées
    def sauvegarder()

        self.raz()

        FileUtils.cd('Grille')
        FileUtils.cd(@taille.to_s())
        tab = Array.new()
        tab = Array.new(YAML::load(File.open('grilles.yml')))
        tab.push(self)
        File.open('grilles.yml',"w"){|out| out.puts tab.to_yaml()}
    end
  
  
# Méthode d'affichage reservee aux tests, affichage uniquement des colonnes
    def afficher()

        @colonne.each { |x|
            
            x.afficher()
        }
    end
end
