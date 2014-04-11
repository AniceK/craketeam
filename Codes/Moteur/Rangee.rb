#13/03/2014
#Projet Picross equipe CrakeTeam
#
#Ce fichier contient la classe Rangee, qui est constituee de Case
#ici une description de la classe Rangee.

class Rangee

    @cases      #tableau de cases
    @conditions   #tableau des "conditions", indiquant comment remplir la grille
    @valide     #booleen indiquant l'etat de la grille

    attr_reader :cases, :valeurs, :valide

#constructeur de la classe Rangee. Récupère en argument le nombre de cases de la rangée
    def Rangee.ajouter(nbreCase)
        
        new(nbreCases)
    end    #marqueur de fin de constructeur

#Initialisateur de la classe Rangee. Récupère en paramètre le nombre de case de la rangee, et initialise un tableau de case de cette taille, ainsi qu'un second tableau, moitié plus petit.    
    def initialize(nbre)

        @cases = Array.new(nbre, Case.creer())
        @conditions = Array.new(nbre/2 + 1)
        @valide = false

    end    #marqueur de fin d initialize

#methode d'instance remplissant le tableau de cases à partir d'un tableau passé en paramètre
    def remplir(tab)

        @case = tab
    end     #marqueur de fin de remplir

	# Méthode permettant de déterminer les conditions à partir d'un tableau

	def conditionsDeterminer(tab)

		cpt = 0
		i = 0

		tab.each { |x|

			if x.etat() == 1 then
				cpt += 1
			else if x.etat() == 0 then
				if cpt != 0 then
					@conditions[i] = cpt
					i += 1
					cpt = 0
				end if
			end if

		}

	end

	#Méthode réinitialisant l'état des cases de la Rangée

	def razCases()
		@cases.each { |x|
			x.raz()
		}
	end

#Methode d'instance vérifiant si la rangée est considérée comme finie (les cases respectent les contraintes.    
    def verifier()

        nbreCaseNoircie = 0
        nbreCaseANoircir = 0
        @cases.each{ |x|
            if x.etat == 1 then nbreCaseNoircie ++
            end if
        }

        @conditions.each{ |x|
            nbreCaseANoircir += x
        }
        
        if nbreCasNoircie != nbreCaseANoircir then
            
            @valide = false
            return false
        end
        
        i = 0   #Compteur pour le tableau de valeurs
        j = 0   #Compteur pour le tableau de cases
        
        while (j < @cases.size && i < @conditions.size) then
             
          while (@cases[j].etat !=1 && j < @cases.size)then
          
            j+=1
          end
             
          nbreCaseNoircie = 0
         
          while (j < @cases.size && nbreCaseNoircie < @conditions[i] && @cases.etat == 1)
            
            j+=1
            nbreCaseNoircie +=1
          end
         
          if (@cases[j].etat == 1 && nbreCaseNoircie >= @conditions[i] || nbreCaseNoircie < @conditions[i])
            
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

        @cases[numero].noircir
    end     #marqueur de fin de noircir
    
#methode d'instance, appelant la methode marquer de la case NUMERO(entier passé en paramètre)

    def marquer(numero)
      
        @cases[numero].marquer
    end
end     #marqueur de fin de class
