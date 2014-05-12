#
##Test des cases
#

require "../Modele/Grille.rb"
require "../Modele/Aide.rb"
require "../Modele/Rangee.rb"

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


ra = Rangee.creer(2)
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

taille = 10
   
puts "Test de la Grille"
g1 = Grille.creer("toto", taille)
aide = Aide.creer(1)
g1.genererAleatoire(20)
g1.noircir(4, 4)
g1.afficher()

for i in (0 ... taille)
    for j in (0 ... taille)

        g1.verifierCoup(i, j)
    end
end


puts"\n"
tmp = aide.chercherAide(g1.colonne, g1.ligne)
puts "\n"

puts tmp

puts g1.termine?().to_s()

