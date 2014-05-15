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

    @grille         # Variable contenant Grille de jeu
    @date           # Variable contenant l'heure et date de la derniere sauvegarde de la partie
    @nom            # Variable contenant le nom de la derniere sauvegarde de la partie
    @joueur         # Variable contenant le nom du joueur qui joue (différent du créateur de la grille)
    @aide           # Variable contient l'IA d'aide
    @temps          # Variable contenant un compteur de temps pour la partie, utilisé pour évaluer le score
    @chronometre    # Variable contenant un processus fils comptant les secondes
    @active         # Variable contenant un booleen définissant si la partie est active (lancée, en cours) ou non


    attr_reader :grille, :aide, :date, :joueur, :temps, :chronometre, :active, :nom

    private_class_method :new

# Méthode de classe de construction de la classe Partie, avec trois paramètres, taille de la grille, difficulte de l'aide, nom du joueur
    def Partie.creer(taille, difficulte, nom)

		  new(taille, difficulte, nom)
    end

# Méthode de classe d'initialisation prenant en paramètre la taille de la grille, le niveau de difficulté de l'aide et le nom du joueur
    def initialize(taille, difficulte, nom)

    # Creation d'une grille(voir Grille.rb)
		@grille = Grille.creer(nom, taille)
    # Initialisation de la date de création/ de sauvegarde
		@date = Time.now
    # Le nom de sauvegarde n'est pas intialisé
        @nom = nil
    # Le joueur est initialisé avec le nom du Profil actuel ou avec par défaut
        @joueur = nom
    # Creation d'une Aide (voir Aide.rb)
        @aide = Aide.creer(difficulte)
    # Le temps de jeu est initialisé à zéro
        @temps = 0
    # La partie n'est pas active (en cours) à sa création
        @active = false
    # Une méthode supplémentaire initialise le chronomètre
        self.initialiserChrono()

    end    #marqueur de fin d initialize

#***************************************
    # Méthodes de gestion du chronomètre(variables @temps, @active et @chronometre)
#***************************************

# Méthode pour initialiser le chronometre, à la création de la partie et à son chargement pour la sérialisation
    def initialiserChrono()
        
    # Un processus fils (pf) est créé pour pouvoir le mettre en pause et le reprendre
        @chronometre = Thread.new {
            
        # Ce pf récupère une date précise à la microseconde
            time = Time.now
        # Le pf boucle ensuite de manière infine
            loop do
               
            # Si jamais la partie n'est plus ou pas active, le chronomètre s'arrête
                if !@active then
                    
                    Thread.stop()
                end

                sleep 0.1
                
             # S'il s'est passé plus d'une seconde depuis le dernier tour de boucle, on incrémente le temps
                if Time.now() - time >= 1.0 then

                    @temps += 1
                    time = Time.now()
                end
            end
        }

    end

# Méthode pour tuer le chronometre, et le vider, nécessaire pour sérialiser une partie.
    def tuerChrono()

        @chronometre.kill()
        @chronometre = nil
    end

# Méthode lançant la partie, en activant le chronomètre
	def lancer()

    # Si la partie n'est pas déjà active, alors on la rend active, et on (re)lance le chronomètre
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

#*************************************
    # Méthodes d'écriture des données
        # Liste de ces méthodes
        # -noircir(int, int)
        # -chargerGrille(String, int)
        # -termine()
        # -chercherAide()
        # -genererAleatoirementGrille()
        # -nettoyerGrille()
        # -marquer(int, int)
#*************************************
    
    #------------------------------------
        # Méthodes de gestion de la grille en lors d'un jeu 
    #------------------------------------
# Methode pour noircir une case et verifier si la colonne et la ligne correspondante sont validées
    def noircir(coordX, coordY)

        @grille.noircir(coordX, coordY)
        @grille.verifierCoup(coordX, coordY)
    end

# Methode pour charger une grille dont le nom et la taille sont passes en parametre
    def chargerGrille(nom, taille)

    # On se déplace dans le dossier correspondant, Grille/taille
        FileUtils.cd('Grille')
        FileUtils.cd(taille.to_s())
        tab = Array.new()

    # Si le fichier de sauvegarde n'est pas vide, on le charge
        if File.size('grilles.yml') > 0 then
            
            tab = YAML::load(File.open('grilles.yml'))
            unTab = Array.new()

         # Tous les noms des sauvegardes sont enregistrés dans un autre tableau
            tab.each { |x|

                unTab.push(x[0])
            }

         # Le nom de grille a charger est chercher dans ce second tableau
            if unTab.include?(nom) then

            # S'il y est, on charge la grille correspondante, et on renvoie true
                @grille = tab[unTab.index(nom)][1]
                FileUtils.cd('../..')
                return true
            else
            
            # Si le nom n'y est pas, on renvoie false
                FileUtils.cd('../..')
                return false
            end
        else
            raise "Erreur dans Partie::chargerGrille(String, int) : aucune grille de cette taille n'existe"
        end
    end


# Méthode testant la fin de partie et l'arretant le cas echeant
	def termine()
        
        if @grille.termine?() then

          @chronometre.kill()
          scores = Array.new()
          if File.size("scores.yml") > 0 then
          
              scores = YAML::load( File.open("scores.yml"))
          end

          scores.push([@grille.taille(),@joueur, temps * 3,])
          File.delete('scores.yml')
          File.open('scores.yml',"w"){|out| out.puts scores.to_yaml()}
          return temps

      else
          return nil
	  end
    end


# Methode pour actualiser l'aide, avec ajout de 10 au temps en tant que pénalité
    def chercherAide()

        @temps += 10
        return @aide.chercherAide(@grille.colonne, @grille.ligne)
    end

# Méthode pour créer une grille aléatoirement
    def genererAleatoirementGrille()

        @grille.genererAleatoire(50)
    end

# Méthode pour remettre la grille en cours à zéro (nettoyer)
    def nettoyerGrille()

        puts "on a demandée a la grille de se remettre à zéro"
        @grille.razGrille()
    end

# Methode de marquage d'une case (X, Y)
    def marquer(x, y)

        @grille.marquerCase(x, y)
    end

    #--------------------------
        # Autres méthodes, pour la sauvegarde d'une partie ou d'une grille
    #--------------------------
# Méthode pour écrire le nom de la sauvegarde dans la partie
    def ecrireNom(unNom)

        @nom = unNom
    end

# Méthode pour sauvegarder une grille à la fin d'une partie
    def sauvegarderGrille(unNom)

        return @grille.sauvegarder(unNom)
    end
# Méthode  pour actualiser la date au moment de la sauvegarde
    def actualiser

        @date = Time.now()
    end

#***********************************
    # Méthodes de lecture de données
#***********************************

# Méthode pour retourner la taille de la grille
    def tailleGrille()

        return @grille.getTaille()
    end

# Méthode pour retourner le nombre de conditions dans la colonne passe en parametre
    def nbConditionsV(x)

            return @grille.nbConditionsV(x)
    end

# Méthode pour retourner le nombre de conditions dans la ligne passe en parametre
    def nbConditionsH(x)

            return @grille.nbConditionsH(x)
    end

# Méthode pour retourner la condition y dans la colonne x passe en parametre
    def conditionV(x, y)

            return @grille.conditionV(x, y)
    end

# Méthode pour retourner la condition y dans la ligne x passe en parametre
    def conditionH(x, y)

            return @grille.conditionH(x, y)
    end

# Méthode pour récuperer l'état d'une case dont on passe les coordonnees en parametres
    def etatCase(x, y)

            return @grille.etatCase(x, y)
    end

# Méthode permettant de renvoyer la Liste des grilles deja existante
	def chargerListeGrillesExistantes(taille, toutes)
        
        FileUtils.cd('Grille')
        FileUtils.cd(taille.to_s())
        
    # Si le fichier contenant les grilles n'est pas vide, il est chargé
        if File.size('grilles.yml') > 0 then
           
            tab = Array.new()
            tab = YAML::load(File.open('grilles.yml'))
            tabInter = Array.new
            unTab = Array.new()
        
        # S'il est spécifié qu'on ne veut que les grilles du Profil actuel, toutes ses grilles sont stockées dans un autre tableau
            if !toutes then

                tabInter = tab.find_all { |x|

                    x[1].createur == @joueur
                }
            else
                
                tabInter = tab
            end
        # Dans un troisieme tableau sont rangées la taille, le nom et la date de création de la grille. Ce tableau est renvoyé
            tabInter.each { |x|
            
                unTab.push([x[1].taille, x[0], x[1].date])
            }

            FileUtils.cd('../..')

            return unTab
        else

            FileUtils.cd('../..')
            return nil
        end

	end
end
