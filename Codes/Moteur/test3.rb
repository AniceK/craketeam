#
##Test des cases
#

load "Grille.rb"
=begin
my_case = Case.creer()
my_case.noircir()
my_case.afficher()
my_case.marquer()
my_case.afficher()
my_case.raz()
my_case.afficher()
=end

=begin
puts "Test des rangees"

c1 = Case.creer()
c2 = Case.creer()
c2.noircir()
tab = Array.new()
tab.push(c1)
tab.push(c2)


ra = Rangee.ajouter(2)
ra.remplir(tab)
#ra.afficher()
ra.noircir(0)
#ra.afficher()
ra.conditionsDeterminer()
ra.noircir(0)
#ra.afficher()
ra.marquer(0)
puts ra.verifier().to_s()
ra.afficher()

=end

puts "Test de la Grille"
g1 = Grille.ajouter("toto", 5)
g1.genererAleatoire(90)
g1.afficher()
