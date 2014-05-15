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
# Variable contenant un tableau de +Rangee+ destinées à être verticales 
    @ligne          
    # Variable contenant un tableau de Rangée destinées à être horizontales
    @grille         
    # Variable contenant une matrice de case
    @createur       
    # Variable contenant le nom du profil ayant créé la grille
    @taille         
    # Variable définissant la taille de la grille
    @nom            
    # Variable contenant le nom de la grille
    @date           
    # Variable contenant la date de création de la grille

    attr_reader :colonne, :ligne, :grille, :createur, :taille, :nom, :date

    private_class_method :new

# Méthode de classe de Création de la classe Grille, ou la taille et le nom du créateur sont passés en paramètres
    def Grille.creer(nom, taille)
    
        new(nom, taille)
    end

# Méthode de classe d'initialisation de la classe Grille
    def initialize(nom, taille)

        @taille = taille
        @date = Time.now()                  # La date est définie à la création
        @colonne = Array.new(taille)        # Création des tableaux pour accueuillir les Rangées
        @ligne = Array.new(taille)
        @grille = Array.new(taille)
        @createur = nom                     # Récupération du nom du créateur passé en paramètre

    # Une boucle est utilisé afin chaque éléments de @ligne, @colonne et @grille avec des Rangées ou des tableaux de Case
        for i in (0 .. taille-1)

            @colonne[i] = Rangee.creer(taille)
            @ligne[i] = Rangee.creer(taille)
            @grille[i] = Array.new(taille)
            
            for j in (0 .. taille-1)

                @grille[i][j] = Case.creer()
            end
        end

    end

#************************************
    # Méthodes d'écriture des données
#************************************

# Méthode vérifiant la validité du coup joué
    def verifierCoup(coordX, coordY)

      @colonne[coordX].verifier()
      @ligne[coordY].verifier()
    end

# Méthode permettant de noircir une Case à partir de ses coordonnées
	def noircir(coordX, coordY)

	    @colonne[coordX].noircir(coordY)
	    @ligne[coordY].noircir(coordX)
        @grille[coordY][coordX].noircir()
	end

# Méthode pour remettre la grille à zéro : cela implique uniquement les tableaux de cases, et non pas ceux de conditions
  def razGrille()
    
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
    
# Méthode de génération aléatoire d'une grille, noircissant au hasarad à l'aide d'un coefficient des cases
    def genererAleatoire(unCoef)

    # Les colonnes et les lignes sont préalablement remises à zéro
       self.razGrille() 
        # Deux boucles parcours l'ensemble des cases, et noircissent selon le coefficient passé en paramètres certaines cases
        for i in (0..@taille-1)
      
            for j in (0..@taille-1)
          
                alea = 0 + Random.rand(100)
          
                if (alea > unCoef) then
              
                    @colonne[i].noircir(j)
                    @ligne[j].noircir(i)
                    @grille[j][i].noircir()

                end
            end
        end

        # Pour chaque ligne et colonne les conditions sont déterminées
	    self.conditionsDeterminer()

        # Toutes les cases noircies sont passées à zéro.
        self.razGrille()
    end

#************************************
    # Méthodes de lecture des données
#************************************

# Méthode renvoyant la taille de la grille
    def getTaille()

        return @taille
    end

# Méthode vérifiant si la partie est terminée, en passant en revue la validité de chacune des Rangées
    def termine?()

        res = true
    # Chaque colonne et chaque ligne sont parcourues pour vérifier si leurs éléments sont valides
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

# Méthode d'affichage reservee aux tests, affichage des lignes dans le terminal
    def afficher()

        @ligne.each { |x|
            
            x.afficher()
            puts "|"
    }
    end

# Méthode pour retourner le nombre de conditions dans la colonne x passe en parametre
    def nbConditionsV(x)

            return @colonne[x].nbConditions()
    end

# Méthode pour retourner le nombre de conditions dans la ligne x passe en parametre
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

# Méthode pour récuperer l'état d'une case dont on passe les coordonnees en parametres
    def etatCase(x, y)

            return @grille[y][x].etat
    end


#*****************************
    # Méthode de sérialisation 
#*****************************

# Méthode de sérialisation de la grille, avec remise à zéro préalable des tableaux de cases des Rangées
    def sauvegarder(unNom)

    # La grille est remise à zéro (pas de case noircie ou marquée)
        self.razGrille()
        @nom = unNom

    # On se déplace dans le répertoir /Grille/Taille, pour charger le fichier contenant toutes les grilles de cette taille
        FileUtils.cd('Grille')
        FileUtils.cd(@taille.to_s())
        tab = Array.new()

    # Si la taille de ce fichier est supérieur à 0 (il n'est donc pas vide), son contenu est chargé dans un tableau tab
        if File.size('grilles.yml') > 0 then
        
            tab = Array.new(YAML::load(File.open('grilles.yml')))
            tabnom = Array.new()

        # Dans un second tableau, on récupère tous les noms de grilles déjà enregistrées
            tab.each { |x|
                tabnom.push(x[0])
            }
        # Si le nom proposé par l'utilisateur est déjà pris, on remonte dans l'arborescence jusqu'à Picross, et on retourne Faux
            if tabnom.include?(unNom) then

                FileUtils.cd('../..')
                return false
            end
        end

    # On ajoute au tableau tab la dernière grille sous la forme d'un tableau contenant son nom de sauvegarde et la grille
        tab.push([@nom, self])

    # On supprime le fichier précédent, pour éviter d'écrire deux fois le tableau tab
        File.delete('grilles.yml')

    # On enregistre via YAML le tableau dans le fichier
        File.open('grilles.yml',"w"){|out| out.puts tab.to_yaml()}

    #On remonte dans l'arborescence et on retourne true, signe que tout s'est bien passé.
        FileUtils.cd('../..')
        return true
    end
    
end
