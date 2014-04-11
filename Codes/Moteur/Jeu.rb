#13/03/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Jeu, qui est constituée d'un Profil et d'une Partie
#ici une description de la classe Jeu.

require 'FileUtils'
require 'yaml'

class Jeu

  @profil
  @partie

  # Constructeur de la classe Jeu
    def Jeu.creer()

        begin

          Dir.chdir "Picross"

        rescue Errno::ENOENT => e

          puts "Le Dossier n'existe pas.. Création de l'arborescence"
          FileUtils.mkdir('Picross')
          FileUtils.cd('Picross')
          FileUtils.mkdir('Profil')
          FileUtils.mkdir('Grille')
          #FileUtils.cp('../GrillesDefauts' '/Grilles')

        else 

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
          
          begin

            Dir.chdir "Grille"

          rescue Errno::ENOENT => f

            puts "Pas de dossier grille.."
            FileUtils.mkdir('Grille')
            puts "Dossier Grille crée !"

          else

            puts "Dossier Grille présent" 
            FileUtils.cd('..')

          end

        ensure

          puts "Initialisation du répertoire fini !"     
          
        end

    end    #marqueur de fin de constructeur

    def initialize()


    end    #marqueur de fin d initialize


	# Méthode permettant de charger le Profil du joueur
	def chargerProfil(unNom)

        aName = unNom.downcase()
        FileUtils.cd('Profil')
        resultat = true

        begin

            Dir.chdir aName
          
        rescue Errno::ENOENT => e

            puts "Le profil #{aName} n'existe pas!"
            resultat = false
            FileUtils.cd('..')

        else

            puts "Le profil #{aName} existe!"
            #afficher une fenetre avec bienvenue truc
            #@profil = YAML::load( File.open('profil.yaml')

        ensure

            return resultat

        end
	end

	def creerProfil(unNom)
        
        aName = unNom.downcase()
        FileUtils.cd('Profil')
        resultat = true

        begin

            Dir.chdir aName
          
        rescue Errno::ENOENT => e
            
            puts "Le profil #{aName} n'existe pas !"
            FileUtils.mkdir(aName)
            FileUtils.cd('..')
            FileUtils.cd('Grille')
            FileUtils.mkdir(aName)
            FileUtils.mkdir('5x5')
            FileUtils.mkdir('10x10')
            FileUtils.mkdir('15x15')
            FileUtils.mkdir('20x20')
            FileUtils.mkdir('25x25')
            FileUtils.cd('../..')
	        @profil = Profil.creer(aName)

          
          else

            puts "Le profil #{aName} existe déjà"
            resultat = false
            FileUtils.cd('..')
          
          ensure

              return resultat

          end

	end


	# Méthode permettant de récupérer une partie
	def chargerPartie()

	end

	def ajouterPartie()
	end

end
