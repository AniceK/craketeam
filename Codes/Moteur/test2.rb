#Test pour la sérialisation

require 'yaml'
require 'fileutils'
load 'Profil.rb'

FileUtils.cd('test')

profil = Profil.creer("Mrtest")
profil1 = Profil.creer("Test1")
profil2 = Profil.creer("Test2")
profil3 = Profil.creer("Test3")

tab = Array.new()

tab.push(profil)
tab.push(profil1)
tab.push(profil2)
tab.push(profil3)

#puts profil.to_yaml
File.open('parties.yml', "w"){|out| out.puts tab.to_yaml}

truc = Array.new(YAML::load(File.open('parties.yml')))

truc.each{|x|
    puts x.nom
}
