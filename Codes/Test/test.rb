#
# Auteur : Tremblain Rémi
# Date : 13/03/14
# Contenu : Test de déplacement dans les dossiers et test de nom
#
require 'fileutils'
require 'yaml'

#===========================================#
#               Arborescence                #
#===========================================#

=begin

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

=end

#===========================================#
#               Timer                       #
#===========================================#

=begin

user_input = Thread.new do
  print "Enter something: "
  Thread.current[:value] = gets.chomp
end

timer = Thread.new { sleep 3; user_input.kill; puts }

user_input.join
if user_input[:value]
  puts "User entered #{user_input[:value]}"
else
  puts "Timer expired"
end

=end

#===========================================#
#               Random avec coef            #
#===========================================#

=begin

coef = 80
cpt = 0

for i in (0..100) do
  bool = (rand(100))
  
  if bool > coef then
    etat = 1
    cpt = cpt + 1
  else
    etat = 0
  end
  
  printf("%i ", etat)
end

printf("\nPourcentage de 1 : %i", cpt)


=end

#===========================================#
#              Chronometre                  #
#===========================================#
=begin
def timer(seconds)
  last_tick = Time.now
  loop do
    sleep 0.1
    if Time.now - last_tick >= seconds
      yield
      last_tick = Time.now
    end
  end
end

t = Time.now

timer(1) do
  p Time.now - t 
end


temps = 0
pause = false
puts temps
chronometre = Thread.new {
    
    time = Time.now
    loop do
        sleep 0.1
    
        if Time.now - time >= 1.0 then

            temps += 1
            puts temps
            time = Time.now
        end
        if pause then
            Thread.stop
        end
    end
}
chronometre.run
while temps < 6
    sleep 0.1
end
pause = true
puts "en pause"
sleep 5
pause = false
chronometre.run
while temps < 16
    sleep 0.1
end
pause = true

puts chronometre.to_yaml()

=end

FileUtils.rm_r('test')
FileUtils.mkdir('test')
FileUtils.rm_r('test')
