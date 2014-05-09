# encoding: utf-8
#! /usr/bin/env ruby
##
#13/03/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Jeu, qui est constituée d'un Profil et d'une Partie
#ici une description de la classe Jeu.

require 'FileUtils'
require 'yaml'

require_relative './Partie'

class Jeu

  @profil
  @partie
  @evenements

  attr_reader :profil, :partie, :evenements

  # Constructeur de la classe Jeu
    def Jeu.creer()

        new()
    end    #marqueur de fin de constructeur

#méthode de classe d'initialisation, ou on initialise les valeurs à nil
    def initialize()

    #Test de la présence d'un dossier Picross, contenant les sauvegardes du jeu (profils, parties, grilles)
        begin

          Dir.chdir "Picross"

        rescue Errno::ENOENT => e

        #Creation de l'arborescence

          puts "Le Dossier n'existe pas.. Création de l'arborescence"
          FileUtils.mkdir('Picross')
          FileUtils.cd('Picross')
          FileUtils.mkdir('Profil')
          FileUtils.mkdir('Grille')
          File.new("scores.yml", "w")
          FileUtils.cd('Grille')
          FileUtils.mkdir('5')
          FileUtils.mkdir('10')
          FileUtils.mkdir('15')
          FileUtils.mkdir('20')
          FileUtils.mkdir('25')
          FileUtils.cd('..')

        else
        
        #Si le dossier existe, on vérifie toutefois son contenu

          puts "Dossier Picross trouvé, vérification de son contenu..."

          begin

            Dir.chdir "Profil"

          rescue Errno::ENOENT => e

            puts "Pas de dossier profil.."
            FileUtils.mkdir('Profil')
            puts "Dossier Profil créé !"

          else

            puts "Dossier Profil présent"
            FileUtils.cd('..')

          end

          File.open("scores.yml", "w")

          begin

            Dir.chdir "Grille"

          rescue Errno::ENOENT => f

            puts "Pas de dossier grille.."
            FileUtils.mkdir('Grille')
            FileUtils.cd('Grille')
            FileUtils.mkdir('5')
            FileUtils.mkdir('10')
            FileUtils.mkdir('15')
            FileUtils.mkdir('20')
            FileUtils.mkdir('25')
            puts "Dossier Grille crée !"
            FileUtils.cd('..')

          else

            puts "Dossier Grille présent"
            
            #test de l'existence des cinq dossiers correspondant aux tailles
            #test de l'existence du dossier 5
            begin

                Dir.chdir "5"

            rescue Errno::ENOENT => e

                puts "Pas de dossier 5.."
                FileUtils.mkdir('5')
                puts "Dossier 5 créé !"

            else

                puts "Dossier 5 présent"
                FileUtils.cd('..')

            end

            begin

                Dir.chdir "10"

            rescue Errno::ENOENT => e

                puts "Pas de dossier 10.."
                FileUtils.mkdir('5')
                puts "Dossier 10 créé !"

            else

                puts "Dossier 10 présent"
                FileUtils.cd('..')

            end

            #Test de la présence du dossier 15
            begin

                Dir.chdir "15"

            rescue Errno::ENOENT => e

                puts "Pas de dossier 15.."
                FileUtils.mkdir('15')
                puts "Dossier 15 créé !"

            else

                puts "Dossier 15 présent"
                FileUtils.cd('..')

            end

            #Test de la présence du dossier 20
            begin

                Dir.chdir "20"

            rescue Errno::ENOENT => e

                puts "Pas de dossier 20.."
                FileUtils.mkdir('20')
                puts "Dossier 20 créé !"

            else

                puts "Dossier 20 présent"
                FileUtils.cd('..')

            end

            #Test de la présence du dossier 25
            begin

                Dir.chdir "25"

            rescue Errno::ENOENT => e

                puts "Pas de dossier 25.."
                FileUtils.mkdir('25')
                puts "Dossier 25 créé !"

            else

                puts "Dossier 25 présent"
                FileUtils.cd('..')

            end


            FileUtils.cd('..')

          end

        ensure

          puts "Initialisation du répertoire fini !"

        end

        @profil = nil
        @partie = nil
        @evenements = nil

    end    #marqueur de fin d initialize


# Méthode permettant de charger le Profil du joueur
	def chargerProfil(unNom)

        aName = unNom.downcase()
        FileUtils.cd('Profil')
        resultat = false

        begin

            Dir.chdir aName

        rescue Errno::ENOENT => e

            puts "Le profil #{aName} n'existe pas!"
            resultat = false
            FileUtils.cd('..')

        else

            puts "Le profil #{aName} existe!"
            #afficher une fenetre avec bienvenue truc
            nom = aName + ".yml"
            @profil = YAML::load( File.open(nom))
            FileUtils.cd('../..')
            resultat = true

        ensure

            return resultat

        end

	end

# Méthode pour récupérer le nom du profil actif
    def nomProfil()

        if @profil != nil then

            return @profil.nom
        else
            raise "Aucun profil n'est chargé!"
        end
    end

# Méthode qui récupère un evenement et initialize evenement
    def ajouterEvenement(event)

        @evenements = event
    end

#Methode d'instance qui initialise la variable d'instance @profil en creant l arborescence correpondante. On retourne un boolen indiquant si le profil existait ou pas (true pour nouveau, false sinon)
	def creerProfil(unNom)

        aName = unNom.downcase()
        FileUtils.cd('Profil')
        resultat = true

    #On tente de se placer dans le Dossier du profil a creer
        begin

            Dir.chdir aName

    #Si cela provoque une erreur, c'est que le dossier, et donc le profil, n'existait pas. On cree donc l'arborescence.
        rescue Errno::ENOENT => e

            puts "Le profil #{aName} n'existe pas !"

    #Appel au constructeur de profil
            FileUtils.mkdir(aName)
            FileUtils.cd(aName)
            @profil = Profil.creer(aName)
            FileUtils.cd('../..')


    #Si le Dossier au nom du profil cree existe deja, alors on le signale
          else

            puts "Le profil #{aName} existe déjà"
            resultat = false
            FileUtils.cd('../..')

          ensure

              return resultat

          end

	end

# Méthode d instance renvoyant la liste des parties sauvegardees du profil en cours
    def chargerListePartiesSauvegardees()

        if @profil == nil then
            
            raise "Aucun profil n'est chargé : impossible de charger la liste des Partie Sauvegardées!"
        else
            
            liste = Array.new()
            FileUtils.cd('Profil')
            FileUtils.cd(@profil.nom)
            FileUtils.cd('Parties')
            liste = YAML::load(File.open('parties.yml'))
            FileUtils.cd('../../..')
            if liste.empty? then
                
                return nil
            else
                return liste
            end
        end

    end


# Méthode recuperant une partie passée en paramètre, et fait de cette partie la partie en cours.
	def chargerPartie(p)

        @partie = p
	end
    
# Méthode supprimant une partie passée en paramètre de la liste des parties sauvegardées
    def supprimmerPartie(p)

        if @profil != nil then
            
            liste = Array.new()
            FileUtils.cd('Profil')
            FileUtils.cd(@profil.nom)
            FileUtils.cd('Parties')
            liste = YAML::load(File.open('parties.yml'))
            
            if liste.empty? then

                return nil
            else
                sup = liste.delete(p)
                File.open('parties.yml',"w"){|out| out.puts liste.to_yaml()}
                FileUtils.cd('../../..')
                return (sup == p)
            end
        else
            raise "Aucun profil n'est chargé : impossible de supprimer une partie!"
        end
 
    end

# Méthode creeant une partie a partir des paramètres
	def creerPartie(taille, difficulte)

        if @profil != nil then

            @partie = Partie.creer(taille, difficulte, @profil.nom())
        else
            @partie = Partie.creer(taille, difficulte, "Visiteur")
        end
    end
# Méthode créant un éditeur de grille à partir des paramètres
    def creerEditeur(taille)

        @partie = Editeur.creer(@profil.nom(), taille)
    end

# Méthode pour afficher les scores, avec le choix entre tous les scores, ou juste ceux du profil en cours
    def afficherScores(tous)

        liste = Array.new()
        liste = YAML::load(File.open('scores.yml'))        

        if @profil == nil or tous then
            
            if liste.empty? then
            
                return nil
            else
                return liste
            end
        else

            return liste.find_all {|i| i[0] == @profil.nom}
        end
    end

# Méthode pour créer un éditeur de grille
    def creerEditeur(taille)

        if @profil == nil then

            raise "Impossible d'utiliser l'editeur sans avoir chargé un profil!"
        else
            @partie = Editeur.creer(@profil.nom, taille)
        end
    end

# Méthode pour déconnecter un profil
    def deconnecter()

        if @profil != nil then
            
            @profil.sauvegarder()
            @profil = nil
        else
            raise "Erreur : pas de profil "
        end
    end

# Méthode pour verifier si un profil est connecté
    def profilConnecte?()

        return @profil != nil
    end

#==============================================
    #Gestion de la Partie en Cours
#==============================================

# Méthode sauvegardant la partie en cours
	def sauvegarderPartie()

        if @partie != nil then

            if @partie.class == Partie then
            
                liste = Array.new()
                FileUtils.cd('Profil')
                FileUtils.cd(@profil.nom)
                FileUtils.cd('Parties')
                liste = YAML::load(File.open('parties.yml'))
                liste.push(@partie)
                File.open('parties.yml',"w"){|out| out.puts liste.to_yaml()}
                FileUtils.cd('../../..')
            else
                raise "Impossible d'appeler sauvergarderPartie() pour autre chose qu'une Partie!"
            end

        else
            
            raise "Aucune partie n'est en cours!"
        end
    end

# Méthode pour retourner la taille de la grille de la partie
    def tailleGrille()

        if @partie != nil then

            return @partie.tailleGrille()
        else
            raise "Aucune partie n'est chargée!"
        end
    end


# Méthode activant/lançant la partie
    def lancerPartie()

        if @partie != nil then

            if @partie.class() == Partie then
            
                @partie.lancer()
            else
                raise "Impossible d'appeler lancerPartie() pour autre chose qu'une partie!"
            end

        else

            raise "Aucune partie n'est en cours!"
        end
    end

# Méthode mettant la partie en pause
    def partieEnPause()

        if @partie != nil then 

            if @partie.class() == Partie then
            
                @partie.pause()
            else
                raise "Impossible d'appeler partieEnPause() pour autre chose qu'une partie!"
            end
        else
            
            raise "Aucune partie n'est en cours!"
        end
    end

# Méthode pour noircir une case dans la partie en cours
    def noircir(x, y)

        if @partie != nil then
            
            @partie.noircir(x, y)
        else

            raise "Aucune partie n'est en cours!"
        end
    end

# Méthode pour marquer une case dans la partie en cours
    def marquer(x, y)

        if @partie != nil then

            if @partie.class() == Partie then
            
                @partie.marquer(x, y)
            else
                raise "Impossible d'appeler marquer(x, y) pour autre chose qu'une partie!"
            end
        else

            raise "Aucune partie n'est en cours!"
        end
    end

# Méthode pour générer aléatoirement une grille dans la partie en cours
    def genererAleatoirementGrille()

        if @partie != nil then

            @partie.genererAleatoirementGrille()
        else

            raise "Aucune partie n'est en cours!"
        end
    end

# Méthode pour activer l'aide
    def chercherAide()

        if @partie != nil then

            if @partie.class() == Partie then 
                
                @partie.chercherAide()
            else
                raise "Impossible de chercher de l'aide en dehors d'une partie!"
            end
        else
            raise "Aucune partie n'est en cours!"
        end
    end

# Méthode pour verifier si la partie en cours est termine
    def termine?()

        if @partie != nil then

            if @partie.classe() == Partie then
                
                return @partie.termine()
            else
                @profil.ajouterUneGrille()
                return @partie.terminer()
            end
        else

            raise "Aucune partie en cours!"
            return 0;
        end
    end

# Méthode pour charger la liste des grilles existantes
    def chargerGrillesExistantes(taille, toutes)

        if @partie != nil then

            if @partie.class() == Partie then

                return @partie.chargerGrillesExistantes(taille, toutes)
            else
                raise "impossible de charger les grilles existantes pour autre chose qu'une partie!"
            end
        else
            raise "Aucune partie en cours!"
            return nil
        end
    end

# Méthode pour retourner le nombre de conditions dans la colonne passe en parametre
    def nbConditionsV(x)

        if @partie.class == Partie then

            return @partie.nbConditionsV(x)
        else
            raise "Erreur, une Partie doit être commencée"
        end
    end
# Méthode pour retourner le nombre de conditions dans la ligne passe en parametre
    def nbConditionsH(x)

        if @partie.class == Partie then

            return @partie.nbConditionsH(x)
        else
            raise "Erreur, une Partie doit être commencée"
        end
    end
# Méthode pour retourner la condition y dans la colonne x passe en parametre
    def conditionV(x, y)

        if @partie.class == Partie then

            return @partie.conditionV(x, y)
        else
            raise "Erreur, une Partie doit être commencée"
        end
    end
# Méthode pour retourner la condition y dans la ligne y passe en parametre
    def conditionH(x, y)

        if @partie.class == Partie then

            return @partie.conditionH(x, y)
        else
            raise "Erreur, une Partie doit être commencée"
        end
    end

# Méthode pour récuperer le temps de la partie
    def tempsactuel()

        if @partie.class == Partie then
            return @partie.temps
        else
            raise "erreur, une partie doit etre aftivée!"
        end
    end

end
