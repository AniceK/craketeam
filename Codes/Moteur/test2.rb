#Test pour la sérialisation

require 'yaml'
load 'Profil.rb'

profil = Profil.creer("Mrtest")
profil.ajouterUneGrille()
profil.ajouterUneGrille()
profil.ajouterUneGrille()

puts profil.to_yaml

File.open('save.yml', "w"){ |out| out.puts profil.to_yaml}

truc = YAML.load_file('save.yml')

puts truc.to_yaml
