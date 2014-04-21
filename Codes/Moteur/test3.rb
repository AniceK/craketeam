#
##Test des cases
#

load "Grille.rb"
load "Aide.rb"
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
aide = Aide.creer(2)
g1.genererAleatoire(50)
#g1.noircirCase(4, 4)
g1.afficher()

for i in (0 .. 4)
    for j in (0 .. 4)

        g1.verifierCoup(i, j)
    end
end

puts"\n"
aide.chercherAide(g1.colonne, g1.ligne)
puts "\n"

puts g1.termine?().to_s()
