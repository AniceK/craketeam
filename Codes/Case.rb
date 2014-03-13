#25/02/2014
#Projet Picross equipe CrakeTeam
#
#Ce fichier contient la classe Case, brique de base du jeu
#ici une description de la classe Case.

class Case

    @etat       #l etat est un entier qui indique si la case a ete noircie, cochee par le joueur ou laisse blanche.
    @statut     #Le statut est un booleen indiquant si la case doit être noircie ou non.

    attr_reader :etat, :statut
    
    def Case.ajouter()
    end    #marqueur de fin de constructeur
    
    def initialize()
    end    #marqueur de fin d initialize

#Cette methode modifie l etat de la case, en lui donnant la valeur passee en parametre (soit 0 pour retour a l etat de base, soit 1 pour noircir ou 2 pour bloquee)
    def noircir(valeur)

        if(valeur < 0 || valeur > 2) then 
            
            raise "La valeur passee en parametre doit etre comprise entre 0 et 2\n"
        end if
        @etat = valeur

    end    #marqueur de fin de methode

#Cette methode modifie le statut de la case. Cette methode ne peut etre appeler qu a la creation de la grille, elle passe le booleen a true
    def modifier()

        @statut = true

    end    #marqueur de fin de methode d instance

end     #marqueur de fin de class
