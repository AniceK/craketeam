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
            nom = aName + ".yml"
            @profil = YAML::load( File.open(nom))

        ensure

            return resultat

        end

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
            @profil = Profil.creer(aName)


#Si le Dossier au nom du profil cree existe deja, alors on le signale
          else

            puts "Le profil #{aName} existe déjà"
            resultat = false
            FileUtils.cd('..')

          ensure

              return resultat

          end

	end

#methode d instance renvoyant la liste des parties sauvegardees du profil en cours
    def chargerListePartiesSauvegardees()

        liste = Array.new()
        FileUtils.cd('Profil')
        FileUtils.cd(@profil.nom)
        FileUtils.cd('Parties')
        liste = YAML::load(File.open('parties.yml'))
        FileUtils.cd('../../..')
        return liste

    end

# Méthode recuperant une partie passée en paramètre, et fait de cette partie la partie en cours.
	def chargerPartie(p)

        @partie = p
	end
    
    def supprimmerPartie(p)

        liste = Array.new()
        FileUtils.cd('Profil')
        FileUtils.cd(@profil.nom)
        FileUtils.cd('Parties')
        liste = YAML::load(File.open('parties.yml'))
        liste.delete(p)
        File.open('parties.yml',"w"){|out| out.puts liste.to_yaml()}
        FileUtils.cd('../../..')
 
    end

	def sauvegarderPartie()

        liste = Array.new()
        FileUtils.cd('Profil')
        FileUtils.cd(@profil.nom)
        FileUtils.cd('Parties')
        liste = YAML::load(File.open('parties.yml'))
        liste.push(@partie)
        File.open('parties.yml',"w"){|out| out.puts liste.to_yaml()}
        FileUtils.cd('../../..')

    end

end
