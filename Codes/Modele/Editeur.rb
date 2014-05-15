# encoding: utf-8
#! /usr/bin/env ruby
##
# Classe Editeur,
# il s'agit d'un module complémentaire à ajouter au Picross
# afin de pouvoir créer ses propre Grille en noircissant une à une les cases qui nous intéresse.
# L'Editeur se chargera de calculer le jeu de conditions et de l'ajouter à la liste de vos Grilles.


class Editeur

	@grille


# Méthode de classe de construction de la classe Editeur
	def Editeur.creer(nom, taille)

		new(nom, taille)

	end

# Méthode de classe d'intialisation de la classe Éditeur
	def initialize(nom, taille)

		@grille = Grille.creer(nom, taille)
	end

# Méthode permettant de noircir une case de la grille (ou de la blanchir si elle était déjà noircie)
	def noircir(coordX, coordY)

		@grille.noircir(coordX, coordY)
	end


# Méthode permettant de calculer les conditions de remplissage à partir des cases noircies
	def conditionsDeterminer()

		@grille.conditionsDeterminer()
	end

# Méthode permettant de sauvegarder la grille
	def sauvegarderGrille(nom)

        self.conditionsDeterminer()
        return @grille.sauvegarder(nom)
    end

# Méthode pour générer aléatoirement un grille, pour permettre à l'utilisateur de se faciliter la création de la grille
    def genenerAleatoirementGrille()

        @grille.genererAleatoire()
    end

# Méthode pour retourner la taille de la grille
    def tailleGrille()

        return @grille.getTaille()
    end
end
