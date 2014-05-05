# Classe Editeur,
# il s'agit d'un module complémentaire à ajouter au Picross
# afin de pouvoir créer ses propre Grille en noircissant une à une les cases qui nous intéresse.
# L'Editeur se chargera de calculer le jeu de conditions et de l'ajouter à la liste de vos Grilles.


class Editeur

	@grille


	# Constructeur
	def Editeur.creer(nom, taille)

		new(nom, taille)

	end

	def initialize(taille)

		@grille = Grille.creer(nom, taille)

	end


	# Méthode permettant de noircir une case de la grille (ou de la blanchir si elle était déjà noircie)
	def noircir(coordX, coordY)

		@grille.noircir(coordxX, coordY)

	end


	# Méthode permettant de calculer les conditions de remplissage à partir des cases noircies
	def conditionsDeterminer()

		@grille.conditionsDeterminer()

	end


	# Méthode permettant de sauvegarder la grille
	def sauvegarder() {



	}


	# Méthode permettant de charger une grille préalamblement amorcée
	def charger(grille)



	end