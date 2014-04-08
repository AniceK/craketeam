#Test pour la sérialisation

require 'yaml'
load 'Profil.rb'

profil = Profil.creer("Mrtest")
profil.ajouterUneGrille()
profil.ajouterUneGrille()
profil.ajouterUneGrille()

puts profil.to_yaml

#stokage = YAML::Store.new("profil1.yml")
#stokage.transaction do
#    profil.to_yaml
#end

#stockage2 = YAML::Store.new("profil1.yml")
