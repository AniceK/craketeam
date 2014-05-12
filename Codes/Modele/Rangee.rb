# encoding: utf-8
#! /usr/bin/env ruby
##
#13/03/2014
#Projet Picross equipe CrakeTeam
#
#Ce fichier contient la classe Rangee, qui est constituee de Case
#ici une description de la classe Rangee.

require_relative "Case.rb"

class Rangee

    @cases      #tableau de cases
    @conditions   #tableau des "conditions", indiquant comment remplir la grille
    @valide     #booleen indiquant l'etat de la grille

    attr_reader :cases, :conditions, :valide

#constructeur de la classe Rangee. Récupère en argument le nombre de cases de la rangée
    def Rangee.creer(nbreCase)

        new(nbreCase)

    end    #marqueur de fin de constructeur

#Initialisateur de la classe Rangee. Récupère en paramètre le nombre de case de la rangee, et initialise un tableau de case de cette taille, ainsi qu'un second tableau, moitié plus petit.
    def initialize(nbre)

        @cases = Array.new(nbre)
        @conditions = Array.new()
        @valide = false

        for i in (0 .. nbre-1)

            @cases[i] = Case.creer()
        end

        self.razCases()

    end    #marqueur de fin d initialize

    #methode recuperant un numero de cas et un etat et mettant la case numero a cet etat
=begin
    def setCase(numero, etat)
        
        @cases[numero].etat = etat
    end
=end

#methode d'instance remplissant le tableau de cases à partir d'un tableau passé en paramètre
    def remplir(tab)

        @cases = tab
    end     #marqueur de fin de remplir

	# Méthode permettant de déterminer les conditions à partir d'un tableau

	def conditionsDeterminer()

        cpt = 0
		@cases.each { |x|

            
            if x.etat == 1 then
                
                cpt += 1

			elsif x.etat != 1 then
                
                if cpt != 0 then
                
                    @conditions.push(cpt)
				
                end

			    cpt = 0
            end

            if (x === @cases.last() and cpt != 0) then
                
                @conditions.push(cpt)
                cpt = 0
            
            end
        }
        if @conditions.empty?() then
            @valide = true
        end
	end

	#Méthode réinitialisant l'état des cases de la Rangée

	def razCases()
		@cases.each { |x|
			x.raz()
		}
	end

#Methode d'instance vérifiant si la rangée est considérée comme finie (les cases respectent les contraintes).
    def verifier()

        nbreCaseNoircie = 0
        nbreCaseANoircir = 0
        
        @cases.each{ |x|
            if x.etat == 1 then 
              
                nbreCaseNoircie+=1
            end
        }
        if @conditions.empty?() and nbreCaseNoircie == 0 then

            puts "la rangee est vide, si aucune case n'est noircie on la valide"
            @valide =true
            return true
        end

        @conditions.each{ |x|
            nbreCaseANoircir += x
        }

        if nbreCaseNoircie != nbreCaseANoircir then

            @valide = false
            return false
        end
        
        i = 0   #Compteur pour le tableau de conditions
        j = 0   #Compteur pour le tableau de cases

        while (j < @cases.size()-1 and i < @conditions.size()-1)

          while (@cases[j].etat !=1 and j < @cases.size()-1)

            j+=1
          end

          nbreCaseNoircie = 0

          while (j < @cases.size()-1 and nbreCaseNoircie < @conditions[i] and @cases[j].etat == 1)

            j+=1
            nbreCaseNoircie +=1
          end

          if (@cases[j].etat == 1 and nbreCaseNoircie >= @conditions[i] or nbreCaseNoircie < @conditions[i]) then
            @valide = false
            return false
          end

          i +=1
        end

        @valide = true
        return true

    end     #marqueur de fin de verifier

#methode d'instance, appelant la methode noircir de la case NUMERO (entier passe en paramètre).
    def noircir(numero)

        @cases[numero].noircir()

    end     #marqueur de fin de noircir

#methode d'instance, appelant la methode marquer de la case NUMERO(entier passé en paramètre)

    def marquer(numero)

        @cases[numero].marquer

    end
    
    #methode vérifiant si la case numero est noircie
    def noircie?(numero)
        return @cases[numero].etat == 1
    end

#methode d'affichage dans un terminal pour les tests
    def afficher()
        
        puts @conditions.to_s()
        @cases.each { |x|
            x.afficher()
        }
        #puts @valide.to_s()
    end

# Méthode pour retourner la condition x
    def condition(x)

        #if x < @conditions.size() then
            return @conditions[x]
        #else
       #     raise "erreur : la valeur envoyée est supérieur a la taille du tableau de condition!", caller
       # end
    end

# Méthode pour retourner la taille du tableau de condition
    def nbConditions

        return @conditions.size()
    end

end     #marqueur de fin de class
