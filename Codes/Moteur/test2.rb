#Test pour la sérialisation

require 'yaml'
require 'fileutils'
load 'Profil.rb'

profil = Profil.creer("Mrtest")
profil.ajouterUneGrille()
profil.ajouterUneGrille()
profil.ajouterUneGrille()

puts profil.to_yaml

File.mkdir(profil.nom)
File.cd()
File.open('save.yml', "w"){ |out| out.puts profil.to_yaml}

#truc = YAML.load_file('save.yml')

truc = YAML::load(File.open('save.yml'))

puts truc.nom
