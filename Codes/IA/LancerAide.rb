#class LancerAide
#
#

load "GrillePicross.rb"

class LancerAide
  maGrille = GrillePicross.Creer(5, 5)
  maGrille.VoirGrille
  
  
  MatriceLignes = maGrille.getTabLignes
  print "\n"
  maGrille.AidePossibleLigne?()
  maGrille.AidePossibleColonne?()
  
  end