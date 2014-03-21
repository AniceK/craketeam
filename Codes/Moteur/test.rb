#
# Auteur : Tremblain Rémi
# Date : 13/03/14
# Contenu : Test de déplacement dans les dossiers et test de nom
#
require 'fileutils'
FileUtils.cd('..')
FileUtils.pwd()

FileUtils.mkdir('Toto')
FileUtils.cd('Toto')