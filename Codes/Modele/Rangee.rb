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

    @cases          # Variable destinée à contenir le tableau de Case de la Rangée
    @conditions     # Variable destinée à contenir le tableau de conditions (entiers naturels positifs) de la Rangée
    @valide         # Variable destinée à contenir le booleen indiquant si la disposition des Ces respecte les conditions

    attr_reader :cases, :conditions, :valide

# Méthode de classe de création de la classe Rangee. Récupère en argument le nombre de cases de la rangée
    def Rangee.creer(nbreCase)

        new(nbreCase)
    end    #marqueur de fin de constructeur

# Méthode de classe d'initialisation de la classe Rangee. Récupère en paramètre le nombre de case de la rangee

    def initialze(nbre)

    # On initialise @cases et @conditions avec des tableaux, et on spécifie la taille du tableau de case
        @cases = Array.new(nbre)
        @conditions = Array.new()
        @valide = false

        for i in (0 .. nbre-1)
            
            # On remplit le tableau @cases de Case à l'aide d'une boucle
                @cases[i] = Case.creer()
        end

    # On s'assure que toutes les @cases seront blanches/vierges
        self.razCases()

    end    #marqueur de fin d initialize

# Méthode permettant de déterminer les conditions à partir d'un tableau
	def conditionsDeterminer()

        cpt = 0
    # On parcours chaque élément de @cases
		@cases.each { |x|

        # Si l'élément est noirci, on incremente le compteur (qui deviendra une condition)
            if x.etat == 1 then
                
                cpt += 1

        # Sinon, si l'élément est blanc et que le compteur n'est plus à zéro, on met le compteur dans le tableau de condition
			elsif x.etat != 1 then
                
                if cpt != 0 then
                
                    @conditions.push(cpt)
				
                end

			    cpt = 0
            end

        # si l'élément est le dernier du tableau @cases, on ajoute le compeur aux @conditions s'il n'est pas nul
            if (x === @cases.last() and cpt != 0) then
                
                @conditions.push(cpt)
                cpt = 0
            end
        }
        if @conditions.empty?() then
            
            @valide = true
            @conditions.push(0)
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
        
    # On calcule le nombre de cases noircies dans @cases
        @cases.each{ |x|
            
            if x.etat == 1 then 
              
                nbreCaseNoircie+=1
            end
        }
    # Si le tableau @conditions est vide(ne contient qu'un 0), 
        if @conditions.first == 0 and nbreCaseNoircie == 0 then

            #puts "la rangee est vide, si aucune case n'est noircie on la valide"
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
        
        print @conditions.to_s()
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
