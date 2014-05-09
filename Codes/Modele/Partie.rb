# encoding: utf-8
#! /usr/bin/env ruby
##
#13/03/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Partie, qui est constituée d'une Grille et de diverses paramètres
#ici une description de la classe Partie.

require_relative 'Grille'
require_relative 'Aide'
require 'fileutils'

class Partie

    @grille
    @creation       #heure et date de la creation de la partie
    @joueur         #nom du joueur qui joue (différent du créateur de la grille)
    @type           #entier signalant de quelle type de partie il s'agit. Pour l'instant, on laisse ce paramètre inutilisé
    @aide           #contient l'IA d'aide
    @temps          #compteur de temps pour la partie, utilisé pour évaluer le score
    @chronometre    #Processus fils comptant les secondes
    @active         #booleen définissant si la partie est active (lancée, en cours) ou non


    attr_reader :grille, :type, :aide, :creation, :joueur, :temps, :chronometre, :active

# Constructeur de la classe Partie
    def Partie.creer(taille, difficulte, nom)

		  new(taille, difficulte, nom)

    end

#méthode de classe d'initialisation prenant en paramètre la taille de la grille, le niveau de difficulté de l'aide et le nom du joueur
    def initialize(taille, difficulte, nom)

		@grille = Grille.creer(nom, taille)
		@creation = Time.now
        @joueur = nom
        @aide = Aide.creer(difficulte)
        @temps = 0
        @active = false
        @chronometre = Thread.new {
            
            time = Time.now
            loop do
                
                sleep 0.1
                
                if Time.now() - time >= 1.0 then

                    @temps += 1
                    time = Time.now()
                end
                if !@active then
                    Thread.stop()
                end
            end
        }


    end    #marqueur de fin d initialize

# Méthode lançant la partie, en activant le chronomètre
	def lancer()

        if !@active then
            
            @active = true
            @chronometre.run()
        else

            raise "Partie déjà en cours!"
        end
	end

#méthode chargée de mettre le chronomètre et la partie en pause
    def pause()

        if @active then
        
        #à la prochaine boucle que fait le chronomètre, il verra que @active est désactivée, et il se mettra en pause
            @active = false
        else

            raise "La partie n'était pas active"
        end
    end

# Méthode permettant de renvoyer la Liste des grilles deja existante
	def chargerGrillesExistantes(taille, toutes)
        
        FileUtils.cd('Grilles')
        FileUtils.cd(taille.to_s())
        tab = Array.new(YAML::load(File.open('grilles.yml')))

        if toutes then

            return tab
        else

            return tab.find_all{ |x|
                x.createur() == @joueur
            }
        end

        FileUtils.cd('../..')

	end

# Methode pour charger une grille passe en parametre
    def chargerGrille(grille)

        @grille = grille
    end


# Methode pour actualiser l'aide
    def chercherAide()

        @aide.chercherAide(@grille.colonne, @grille.ligne)
    end

# Methode pour noircir une case et verifier si la colonne et la grille correspondante sont validées
    def noircir(coordX, coordY)

        @grille.noircir(coordX, coordY)
        @grille.verifierCoup(coordX, coordY)
    end

# Méthode testant la fin de partie et l'arretant le cas echeant
	def termine()
        
        if @grille.termine?() then

          self.pause()
          scores = Array.new()
          scores = YAML::load( File.open("scores.yml"))
          scores.push([@joueur, temps * 10, @grille.taille()])
          File.open('scores.yml',"w"){|out| out.puts scores.to_yaml()}
          return temps

      else
          return nil
	  end
    end

#=================================================
    #ici commencent les méthodes de retransmission
#=================================================
 
# Méthode pour créer une grille aléatoirement
    def genererAleatoirementGrille()

        @grille.genererAleatoire()
        @grille.sauvegarder()
    end

# Methode de marquage d'une case (X, Y)
    def marquer(x, y)

        @grille.marquer(x, y)
    end

# Méthode pour retourner la taille de la grille
    def tailleGrille()

        return @grille.taille
    end
  
end
