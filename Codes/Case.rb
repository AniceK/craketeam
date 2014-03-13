#25/02/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Case, brique de base du jeu
#ici une description de la classe Case.

class Case

    @etat       #l'état est un entier qui indique si la case a été noircie, cochée par le joueur ou laissée blanche.

    attr_reader :etat
    
    def Case.creer()
    end    #marqueur de fin de constructeur
    
    def initialize()
    end    #marqueur de fin d'initialize

#Cette méthode modifie l'état de la case, en lui donnant la valeur passée en paramètre (soit 0 pour retour a l'état de base, soit 1 pour noircir ou 2 pour bloquer)
    def noircir(valeur)

        if(valeur < 0 || valeur > 2) then 
            
            raise "La valeur passee en parametre doit etre comprise entre 0 et 2\n"
        end if
        @etat = valeur

    end    #marqueur de fin de methode

end     #marqueur de fin de class
