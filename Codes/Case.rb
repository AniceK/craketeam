#25/02/2014
#Projet Picross equipe CrakeTeam
#
#Ce fichier contient la classe Case, brique de base du jeu
#ici une description de la classe Case.

class Case

    @etat       #l etat indique si la case a ete cochée par le joueur ou laissee blanche.
    @statut     #Le statut indique si la case doit être cochée ou non.
    
    def Case.ajouter()
    end    #marqueur de fin de constructeur
    
    def initialize()
    end    #marqueur de fin d initialize

#Cette methode modifie l etat de la case, en lui donnant la valeur passee en parametre (comprise entre 0 et 2)
    def cocher(valeur)

    end    #marqueur de fin de methode

#Cette methode modifie le statut de la case. Cette methode ne peut etre appeler qu a la creation de la grille
    def modifier()

    end    #marqueur de fin de methode d instance

end     #marqueur de fin de class
