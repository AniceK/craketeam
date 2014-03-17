#
# Auteur : Tremblain Rémi
# Date : 13/03/14
# Contenu : Test de déplacement dans les dossiers et test de nom
#

class Test
  
  @nom
  @chemin
  
  attr :nom, true
  attr :chemin, true
  
  private_class_method :new
  
  def Test.Nouveau(unNom)
    new(unNom)
  end
  
  def initialize(unNom)
    @nom = unNom
  end
  
  #Methode de vérification de la présence du nom dans l'arborescence
  def estPresent?()
    system("echo #{@nom}")
  end
end

j=Test.Nouveau('remi')
j.estPresent?()