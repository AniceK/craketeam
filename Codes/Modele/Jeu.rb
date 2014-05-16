# encoding: utf-8
#! /usr/bin/env ruby
##
#13/03/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Jeu, qui est constituée d'un Profil et d'une Partie
#ici une description de la classe Jeu.

require 'fileutils'
require 'yaml'

require_relative './Partie'
require_relative './Profil'
require_relative './Editeur'

class Jeu
    
    @profil       # Variable contenant le profil actif, initialisée à nil
    @partie       # Variable contenant la Partie ou l'Editeur en cours, initialisée à nil
    @evenements   # Variable contenant un evenment (pour le contrôleur)
    @verbose      # Variable contenant un boolean pour afficher les étapes

    attr_reader :profil, :partie, :evenements, :verbose

    private_class_method :new

# Méthode de classe de construction de la classe Jeu
    def Jeu.creer(v)

        new(v)
    end    #marqueur de fin de constructeur

# Méthode de classe d'initialisation
    def initialize(v)

    @verbose = v

    #Test de la présence d'un dossier Picross, contenant les sauvegardes du jeu (profils, parties, grilles)
        begin

          Dir.chdir "Picross"

        rescue Errno::ENOENT => e

        #Creation de l'arborescence

            if @verbose then 
                
                puts "Le Dossier n'existe pas.. Création de l'arborescence" 
            end
            FileUtils.mkdir('Picross')
            FileUtils.cd('Picross')
            FileUtils.mkdir('Profil')
            File.new("scores.yml", "w")
            self.creerArboGrille()

        else
        
        #Si le dossier existe, on vérifie toutefois son contenu

          if @verbose then 
              
              puts "Dossier Picross trouvé, vérification de son contenu..."
          end

          begin
              
              Dir.chdir "Profil"

          rescue Errno::ENOENT => e
              
              if @verbose then 
                  
                  puts "Pas de dossier profil.." 
              end

              FileUtils.mkdir('Profil')

              if @verbose then 
                  
                  puts "Dossier Profil créé !" 
              end

          else

              if @verbose then puts "Dossier Profil présent" end
              FileUtils.cd('..')

          end

          begin
              
              Dir.chdir "Grille"

          rescue Errno::ENOENT => f
              
              if @verbose then
                  
                  puts "Pas de dossier grille.. Creation de l'arborescence correspondante" 
              end
            
              self.creerArboGrille()
              
              if @verbose then 
                  
                  puts "Dossier Grille crée !" 
              end
              
              FileUtils.cd('..')

          else

              if @verbose then 
                  
                  puts "Dossier Grille présent" 
              end
            
          #test de l'existence des cinq dossiers correspondant aux tailles
          #test de l'existence du dossier 5
            begin

                Dir.chdir "5"

            rescue Errno::ENOENT => e

                if @verbose then 
                    
                    puts "Pas de dossier 5.." 
                end
                self.creerArboTaille(5)
                
                if @verbose then 
                    
                    puts "Dossier 5 créé !"
                end

            else

                if @verbose then
                    
                    puts "Dossier 5 présent"
                end
                FileUtils.cd('..')

            end

            begin

                Dir.chdir "10"

            rescue Errno::ENOENT => e

                if @verbose then 
                    puts "Pas de dossier 10.."
                end
                self.creerArboTaille(10)
                if @verbose then 
                    puts "Dossier 10 créé !" 
                end

            else

                if @verbose then 
                    puts "Dossier 10 présent" 
                end
                FileUtils.cd('..')

            end

            #Test de la présence du dossier 15
            begin

                Dir.chdir "15"

            rescue Errno::ENOENT => e

                if @verbose then 
                    
                    puts "Pas de dossier 15.." 
                end
                self.creerArboTaille(15)
                if @verbose then 
                    
                    puts "Dossier 15 créé !" 
                end

            else

                if @verbose then puts "Dossier 15 présent" end
                FileUtils.cd('..')

            end

            #Test de la présence du dossier 20
            begin

                Dir.chdir "20"

            rescue Errno::ENOENT => e

                if @verbose then 
                    
                    puts "Pas de dossier 20.." 
                end
                self.creerArboTaille(20)
                if @verbose then 
                    
                    puts "Dossier 20 créé !" 
                end

            else

                if @verbose then puts "Dossier 20 présent" end
                FileUtils.cd('..')

            end

            #Test de la présence du dossier 25
            begin

                Dir.chdir "25"

            rescue Errno::ENOENT => e

                if @verbose then 
                    
                    puts "Pas de dossier 25.." 
                end
                self.creerArboTaille(25)
                if @verbose then 
                    
                    puts "Dossier 25 créé !" 
                end

            else

                if @verbose then puts "Dossier 25 présent" end
                FileUtils.cd('..')

            end


            FileUtils.cd('..')

          end

        ensure

            if @verbose then 
                
                puts "Initialisation du répertoire fini !" 
            end

        end

        @profil = nil
        @partie = nil
        @evenements = nil

    end    #marqueur de fin d initialize


#**************************************
    #Méthodes de gestion d'arborescence
#**************************************
    #
# Méthode pour créer l'arborescence du dossier Grille
    def creerArboGrille()

        FileUtils.mkdir('Grille')
        FileUtils.cd('Grille')

        for i in [5, 10, 15, 20, 25]
            
            creerArboTaille(i)
        end
        FileUtils.cd('..')
    end

# Méthode pour créer l'arborescence d'un dossier de taille de grille
    def creerArboTaille(taille)
        
        FileUtils.mkdir(taille.to_s())
        FileUtils.cd(taille.to_s())
        File.open("grilles.yml", "w")
        FileUtils.cd('..')
    end

# Méthode pour réinitialiser l'arborescence
    def viderTout()

        FileUtils.rm_r('Profil')
        FileUtils.rm_r('Grille')
        File.delete('scores.yml')
        FileUtils.mkdir('Profil')
        self.creerArboGrille()
        File.new('scores.yml', "w")
    end


# Méthode pour vider toutes les grilles existantes
    def viderGrilles()

        if @profil!= nil then
            
            FileUtils.cd('Grille')
            for i in [5, 10, 15, 20, 25]

                FileUtils.cd(i.to_s)
                File.delete('grilles.yml')
                File.new('grilles.yml', "w")
                FileUtils.cd('..')
            end
            FileUtils.cd('..')
        else

            raise "Erreur dans Jeu::viderGrille() : un Profil doit être actif"
        end
    end

# Méthode pour vider les parties sauvegardées
    def viderParties

        if @profil != nil then

            FileUtils.cd('Profil')
            FileUtils.cd(self.nomProfil())
            File.delete('parties.yml')
            File.new('parties.yml', "w")
            FileUtils.cd('../..')
        end
    end



#****************************************
    # Méthodes de gestion du Profil actif
#****************************************

# Méthode permettant de charger le Profil du joueur
	def chargerProfil(unNom)

        aName = unNom.downcase()
        FileUtils.cd('Profil')
        resultat = false

        begin

            Dir.chdir aName

        rescue Errno::ENOENT => e

            if @verbose then puts "Le profil #{aName} n'existe pas!" end
            resultat = false
            FileUtils.cd('..')

        else

            if @verbose then puts "Le profil #{aName} existe!" end
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

            if @verbose then puts "Le profil #{aName} n'existe pas !" end

    #Appel au constructeur de profil
            FileUtils.mkdir(aName)
            FileUtils.cd(aName)
            @profil = Profil.creer(aName)
            File.new("parties.yml", "w")
            FileUtils.cd('../..')


    #Si le Dossier au nom du profil cree existe deja, alors on le signale
          else

            if @verbose then 
                
                puts "Le profil #{aName} existe déjà" 
            end
            resultat = false
            FileUtils.cd('../..')

          ensure

              return resultat

          end

	end

# Méthode pour déconnecter un profil
    def deconnecter()

        if @profil != nil then
            
            @profil.sauvegarder()
            @profil = nil
        else
            raise "Erreur dans Jeu::deconnecter() : un Profil doit être actif"
        end
    end

# Méthode pour verifier si un profil est connecté
    def profilConnecte?()

        return @profil != nil
    end

#***********************************
    # Méthodes d'écriture de données
#***********************************

# Méthode qui récupère un evenement et initialize evenement
    def ajouterEvenement(event)

        @evenements = event
    end

# Méthode supprimant une partie passée en paramètre de la liste des parties sauvegardées
    def supprimmerPartie(unNom)

        if @profil != nil then
            
            if @verbose then 
                
                puts "suppression d'une partie!" 
            end

            liste = Array.new()
            FileUtils.cd('Profil')
            FileUtils.cd(@profil.nom)

            if File.size('parties.yml') > 0 then
            
                liste = YAML::load(File.open('parties.yml'))
                listeNoms = Array.new()
                
                if !list.empty?() then
                
                    liste.each { |x|

                        listeNoms.push(x[0])
                    }
                    if (index = listeNoms.index(unNom)) != nil then

                        sup = liste.delete_at(index)
                        File.delete('parties.yml')
                        File.open('parties.yml',"w"){|out| out.puts liste.to_yaml()}
                        FileUtils.cd('../..')
                        return (sup == p)
                    else
                   
                        raise "Erreur dans Jeu::supprimerPartie(String) : aucune sauvegarde sous ce nom : #{unNom}"
                    end
                else
                    raise "Erreur dans Jeu::supprimerPartie(String) : aucune sauvegarde existante"
                end
            else
                raise "Erreur dans Jeu::supprimerPartie(String) : aucune sauvegarde existante"
            end
        else
            raise "Erreur dans Jeu::supprimerPartie(String) : un Profil doit être actif"
        end 
    end

# Méthode pour supprimer une grille dont on passe le nom et la taille en paramètre
    def supprimerGrille(unNom, taille)

        FileUtils.cd('Grille')
        FileUtils.cd(taille.to_s())

        if File.size('grilles.yml') > 0 then

            liste = Array.new()
            liste = YAML::load(File.open('grilles.yml'))

            listeNom = Array.new()

            liste.each { |x|

                listeNom.push(x[0])
            }

            if listeNom.include?(unNom) then

                liste.delete_at(listeNom.index(unNom))
                FileUtils.cd('../..')
                return true
            else
                FileUtils.cd('../..')
                return false
            end
        else
            FileUtils.cd('../..')
            return false
        end
    end

#**********************************
    # Méthode de lecture de données
#**********************************

# Méthode d instance renvoyant la liste des parties sauvegardees du profil en cours
    def chargerListePartiesSauvegardees()

        if @profil == nil then
            
            raise "Erreur dans Jeu::chargerListePartiesSauvegardees() : un Profil doit être actif"
        else
            
            if @verbose then puts "chargement de la liste des parties sauvegardees du profil" + @profil.nom end
            
            liste = Array.new()
            FileUtils.cd('Profil')
            FileUtils.cd(@profil.nom)

            if File.size('parties.yml') <= 0 then
                
                FileUtils.cd('../..')
                if @verbose then puts "La liste des parties sauvegardées est vide!" end
                return nil
            else

                liste = YAML::load(File.open('parties.yml'))
                FileUtils.cd('../..')

                if !liste.empty?() then
                    tab = Array.new()

                    liste.each{ |x|

                        tab.push([x[1].tailleGrille(), x[0], x[1].date])
                    }

                    return tab
                    
                else
                    return nil
                end
            end
        end

    end

# Méthode pour afficher les scores
    def afficherScores()

        liste = Array.new()
        if File.size('scores.yml')> 0 then
            
            liste = YAML::load(File.open('scores.yml'))        
            return liste.sort()
        else

            return nil
        end
    end


#****************************************
    #Méthode de gestion de Partie/Editeur
#****************************************

    #---------------------
    #Méthode d'écriture
    #---------------------
# Méthode recuperant une partie passée en paramètre, et fait de cette partie la partie en cours.
	def chargerPartie(unNom)

        liste = Array.new()
        liste = self.chargerListePartiesSauvegardees()
        if liste.empty? then
            
            return false
        else

            listeNom = Array.new()
            liste.each { |x|
                
                listeNom.push(x[1])
            }
            if listeNom.include?(unNom) then
              
                taille = liste[listeNom.index(unNom)][0]
                FileUtils.cd('Profil')
                FileUtils.cd(nomProfil())
                listePartie = YAML::load(File.open('parties.yml'))
                
                listePartie.each { |x|

                    listeNom.push(x[0])
                }
                
                FileUtils.cd('../..')
                
                if listeNom.include?(unNom) then

                    @partie = listePartie[listeNom.index(unNom)][1]
                    @partie.initialiserChrono()
                    
                    return(@partie != nil)
                    
                end
                
            else

                return false
            end
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

# Méthode pour créer un éditeur de grille
    def creerEditeur(taille)

        if @profil == nil then

            raise "Erreur dans Jeu::creerEditeur(int) : un Profil doit être actif"
        else
            @partie = Editeur.creer(@profil.nom, taille)
        end
    end

# Méthode pour vider le contenu de @partie
    def quitterPartie()

        @partie = nil
    end

# Méthode sauvegardant la partie en cours
	def sauvegarderPartie(nomSauvegarde)

        if @partie.class == Partie then
        
            liste = Array.new()
            FileUtils.cd('Profil')
            FileUtils.cd(@profil.nom)

            if File.size("parties.yml") > 0 then
            
                liste = YAML::load(File.open('parties.yml'))
                listenom = Array.new()
                liste.each { |x|

                    listenom.push(x[0])
                }
                if listenom.include?(nomSauvegarde) then
                   
                    FileUtils.cd('../..')
                    return false
                end
            end
            @partie.tuerChrono()
            @partie.actualiser()
            @partie.ecrireNom(nomSauvegarde)
            liste.push([nomSauvegarde, @partie])
            File.delete('parties.yml')
            File.open('parties.yml',"w"){|out| out.puts liste.to_yaml()}
            FileUtils.cd('../..')
            return true

        else
            
            raise "Erreur dans Jeu::sauvegarderPartie(String) : une Partie doit être active"
        end
    end

# Méthode pour sauvegarder une grille, soit par l'éditeur, soit à la fin d'une partie
    def sauvegarderGrille(unNom)

        if @partie!= nil then

            if @partie.class == Partie then

                return @partie.sauvegarderGrille(unNom)
            else
                @profil.ajouterUneGrille()
                return @partie.sauvegarderGrille(unNom)
            end
        else
            raise "Erreur dans Jeu::sauvegarderGrille(String) : Aucune partie n'est en cours"
        end
    end

# Méthode pour vider/nettoyer la grille(tout remettre à zéro)
    def nettoyerGrille()

        if @partie != nil then

            @partie.nettoyerGrille()
        else
            raise "Erreur : impossible de nettoyer la grille si ni éditeur ou partie n'ont été lancés!"
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
            
            if @partie.class == Partie then
              return termine?()
            end
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

# Méthode pour charger une grille dont le nom est passé en paramètre
    def chargerGrille(nom, taille)

        if @partie.class == Partie then

            return @partie.chargerGrille(nom, taille)
        else
            raise "erreur : une partie doit etre en cours"
        end
    end

# Méthode pour vider le contenu de @partie
    def quitterPartie()

        @partie = nil
    end

# Méthode pour remplacer une sauvegarde existante par une nouvelle partie
    def remplacerSauvegarde(unNom)

        if @partie.class == Partie then

            self.supprimmerPartie(unNom)
            self.sauvegarderPartie(unNom)
        end
    end

    #--------------------
    # Méthodes de lecture
    #--------------------

# Méthode pour retourner la taille de la grille de la partie
    def tailleGrille()

        if @partie != nil then

            return @partie.tailleGrille()
        else
            raise "Aucune partie n'est chargée!"
        end
    end


# Méthode pour activer l'aide
    def chercherAide()

        if @partie != nil then

            if @partie.class() == Partie then 
                
                return @partie.chercherAide()
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

            if @partie.class() == Partie then
                
                return @partie.termine()
            else

                raise "Une partie doit etre en cours"
            end
        else

            raise "Aucune partie en cours!"
            return 0;
        end
    end

# Méthode pour charger la liste des grilles existantes
    def chargerListeGrillesExistantes(taille, toutes)

        if @partie != nil then

            if @partie.class() == Partie then

                return @partie.chargerListeGrillesExistantes(taille, toutes)
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

        if @partie != nil then

            return @partie.nbConditionsV(x)
        else
            raise "Erreur, une Partie doit être commencée"
        end
    end
# Méthode pour retourner le nombre de conditions dans la ligne passe en parametre
    def nbConditionsH(x)

        if @partie != nil then

            return @partie.nbConditionsH(x)
        else
            raise "Erreur, une Partie doit être commencée"
        end
    end

# Méthode pour retourner la condition y dans la colonne x passe en parametre
    def conditionV(x, y)

        if @partie != nil then

            return @partie.conditionV(x, y)
        else
            raise "Erreur, une Partie doit être commencée"
        end
    end

# Méthode pour retourner la condition y dans la ligne y passe en parametre
    def conditionH(x, y)

        if @partie != nil then

            return @partie.conditionH(x, y)
        else
            raise "Erreur, une Partie doit être commencée"
        end
    end

# Méthode pour récuperer le temps de la partie
    def tempsActuel()

        if @partie.class == Partie then

            return @partie.temps
        else
            raise "erreur, une partie doit etre activée!"
        end
    end

# Méthode pour récuperer l'état d'une case dont on passe les coordonnees en parametres (utile au chargement d'une partie sauvegardee)
    def etatCase(x, y)

        if @partie.class == Partie then

            return @partie.etatCase(x, y)
        else
            raise "erreur : cette methode doit etre appelee lorsqu'une partie est active"
        end
    end

# Méthode pour récuperer le nom de la sauvegarde
    def nomSauvegardeDefaut()

        if @partie.class == Partie then

            return @partie.nom
        else
            raise "erreur : une partie doit être en cours pour demander le nom de la dernière sauvegarde de cette partie"
        end
    end
end
