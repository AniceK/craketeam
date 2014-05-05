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

	def lancerPartie()

		while(!termine()) {

			coup(x,y)
			verifie(x,y)
			if @aide then

			end

		}

	end

end
