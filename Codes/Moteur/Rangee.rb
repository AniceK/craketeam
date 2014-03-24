#13/03/2014
#Projet Picross equipe CrakeTeam
#
#Ce fichier contient la classe Rangee, qui est constituee de Case
#ici une description de la classe Rangee.

class Rangee

    @cases
    @valeurs

    attr_reader :cases, :valeurs

#constructeur de la classe Rangee. Récupère en argument le nombre de cases de la rangée
    def Rangee.ajouter(nbreCase)
        
        new(nbreCases)
    end    #marqueur de fin de constructeur

#Initialisateur de la classe Rangee. Récupère en paramètre le nombre de case de la rangee, et initialise un tableau de case de cette taille, ainsi qu'un second tableau, moitié plus petit.    
    def initialize(nbre)

        @cases = Array.new(nbre, Case.creer())
        @valeurs = Array.new(nbre/2 + 1)

    end    #marqueur de fin d initialize

#methode d'instance remplissant le tableau de valeurs à partir d'un tableau passé en paramètre
    def remplir(tab)

        @valeurs = tab
    end     #marqueur de fin de remplir

#Methode d'instance vérifiant si la rangée est considérée comme finie (les cases respectent les contraintes.    
    def verifier()
    end     #marqueur de fin de verifier

#methode d'instance, appelant la methode noircir de la case NUMERO (entier passe en paramètre) avec le paramètre TYPE.
    def noircir(numero, type)

        @cases[numero].noircir(type)
    end     #marqueur de fin de noircir

end     #marqueur de fin de class
