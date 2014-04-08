#
# Auteur : Tremblain Rémi
# Date : 13/03/14
# Contenu : Test de déplacement dans les dossiers et test de nom
#
require 'fileutils'

begin
  Dir.chdir "Picross"
rescue Errno::ENOENT => e
  puts "Le Dossier n'existe pas.. Création de l'arborescence"
  FileUtils.mkdir('Picross')
  FileUtils.cd('Picross')
  FileUtils.mkdir('Profil')
  FileUtils.mkdir('Grille')
else  
  puts "Dossier Picross trouvé, vérification de son contenu..."
  
  begin
    Dir.chdir "Profil"
  rescue Errno::ENOENT => e
    puts "Pas de dossier profil.."
    FileUtils.mkdir('Profil')
    puts "Dossier Profil créé !"
  else
    puts "Dossier Profil présent"
    FileUtils.cd('..')    
  end
  
  begin
    Dir.chdir "Grille"
  rescue Errno::ENOENT => f
    puts "Pas de dossier grille.."
    FileUtils.mkdir('Grille')
    puts "Dossier Grille crée !"
  else
    puts "Dossier Grille présent" 
     FileUtils.cd('..')   
  end

ensure
  puts "Initialisation du répertoire fini !"     
  
end
