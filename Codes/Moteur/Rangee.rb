#13/03/2014
#Projet Picross equipe CrakeTeam
#
#Ce fichier contient la classe Rangee, qui est constituee de Case
#ici une description de la classe Rangee.

class Rangee

    @cases
    @valeurs

    attr_reader :cases, :valeurs
    
    def Rangee.ajouter(nbreCase)
        
        new(nbreCases)
    end    #marqueur de fin de constructeur
    
    def initialize(nbre)

        @cases = Array.new(nbre, Case.creer())
        @valeurs = Array.new(nbre/2 + 1)

    end    #marqueur de fin d initialize

    def verifier()
    end     #marqueur de fin de verifier

    def noircir(numero, type)

        @cases[numero].noircir(type)
    end     #marqueur de fin de noircir

end     #marqueur de fin de class
