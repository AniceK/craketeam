# encoding: utf-8
#! /usr/bin/env ruby
##
#25/02/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Aide

#Encoding: UTF-8

class Aide
  
  @difficulte
  @tabCondCol
  @tabCondLig
  
   attr_reader :difficulte, :tabCondCol, :tabCondLig
  
	# Constructeur de la classe Aide
    def Aide.creer(uneDifficulte)

		  new(uneDifficulte)

    end

    def initialize(uneDifficulte)

		  @difficulte = uneDifficulte
      @tabCondCol = Array.new()
      @tabCondLig = Array.new()

    end    #marqueur de fin d initialize
    
  def chercherAide(tabCol, tabLig)
    
    strMessage = ""
    tabTaille = tabCol.size()
    
    tabCol.each{ |x|
      tabCondCol.push(x.conditions)
    }
    
    tabLig.each{ |x|
      tabCondLig.push(x.conditions)
    }
    
    case difficulte
      
      when 1
        strMessage += "Difficulté de niveau 1\nLa totale\n"
        
      when 2
        strMessage += "Difficulté de niveau 2\nIndication des lignes à potentiel\nVérification des lignes\n"
        
      when 3
        strMessage += "Difficulté de niveau 3\nVérification des lignes\n"
        
    end
    
    if difficulte == 1 || difficulte == 2 then
    
      #====      Colonne     ====#
    
      pos = 1

      strMessage += "\nCondition des colonnes\n"
      for tabTabCol in tabCondCol
        totalCol = 0
      
        for valCol in tabTabCol 
          totalCol += valCol
        end
      
        #puts "Total de la colonne #{pos} : #{totalCol}"
      
        if totalCol == tabTaille then
          if difficulte == 1
            strMessage += "Colonne #{pos} : pleine\n"
          else
            strMessage += "Colonne #{pos}\n" 
          end
        
        elsif totalCol == 0
          if difficulte == 1
             strMessage += "Colonne #{pos} : vide\n"
          else
             strMessage += "Colonne #{pos}\n"
          end
        
        elsif tabTabCol.count > tabTaille/2 && tabTaille%2 == 1
          if difficulte == 1
            strMessage += "Colonne #{pos} : une case sur deux en partant du bord\n"
          else
            strMessage += "Colonne #{pos}\n"
          end
        
        elsif tabTabCol.count == 1 && totalCol > tabTaille/2 
          if tabTaille%2 == 1
            if difficulte == 1
              strMessage += "Colonne #{pos} : #{tabTaille-(tabTaille-totalCol)*2} case#{ (tabTaille-(tabTaille-totalCol)*2)>1 ? "s":""} à colorier au centre\n"
            else
               strMessage += "Colonne #{pos}\n"
            end
          else
            if difficulte == 1
              strMessage += "Colonne #{pos} : #{tabTaille-(tabTaille-totalCol)*2} cases à colorier au centre\n"
            else
              strMessage += "Colonne #{pos}\n"
            end
          end
            
        elsif totalCol == tabTaille - (tabTabCol.count - 1)
          if difficulte == 1
            strMessage += "Colonne #{pos} : 1 case blanche entre chaque condition\n"
          else
            strMessage += "Colonne #{pos}\n"
          end
          
        elsif 
            #voir le traitement des lignes / colonnes
            
            
            
        end
            
        else
          if difficulte == 1
              #strMessage += "Colonne #{pos}: aucune aide disponible\n"
          end
        end
      
        pos += 1
      end
    
      #====      Ligne     ====#
    
    
      pos = 1
    
      strMessage += "\nCondition des lignes\n"
      for tabTabLig in tabCondLig
        totalLig = 0
      
        for valLig in tabTabLig 
          totalLig += valLig
        end
      
        #puts "Total de la ligne #{pos} : #{totalLig}"
      
        if totalLig == tabTaille then
          if difficulte == 1
            strMessage += "Ligne #{pos} : pleine\n"
        
          else
            strMessage += "Ligne #{pos}\n"
          end
        
        elsif totalLig == 0 
          strMessage += "Ligne #{pos} : vide\n"
        
        elsif tabTabLig.count > tabTaille/2 && tabTaille%2 == 1
          if difficulte == 1
            strMessage += "Ligne #{pos} : une case sur deux est noir en partant du bord\n"
          
          else
            strMessage += "Ligne #{pos}\n"
          end
        
        elsif tabTabLig.count == 1 && totalLig > tabTaille/2
          if tabTaille%2 == 1
            if difficulte == 1
              strMessage += "Ligne #{pos} : #{tabTaille-(tabTaille-totalCol)*2} case#{(tabTaille-(tabTaille-totalCol)*2)>1 ? "s":""} a colorier au centre\n"
            else
              strMessage += "Ligne #{pos}\n"
            end
        
          else
            if difficulte == 1
             strMessage += "Ligne #{pos} : #{tabTaille-(tabTaille-totalCol)*2} cases a colorier au centre\n"
            else
              strMessage += "Ligne #{pos}\n"
            end
          end
          
        elsif totalLig == tabTaille - (tabTabLig.count - 1)
          if difficulte == 1
            strMessage += "Ligne #{pos} : 1 case blanche entre chaque condition\n"
          else
            strMessage += "Ligne #{pos}\n"
          end
          
        else
          if difficulte == 1
            #strMessage += "Ligne #{pos} : aucune aide disponible\n"
          end
        end
      
        pos += 1
      end
    end
    
    strMessage += "\nVérification des lignes et des colonnes\n"
    
    #puts "\nVérification des lignes\n"
    posLig = 0
    for x in tabLig
      tmp = true
      if x.valide() == false then #Change to true pour les tests
        tmp = false
      end
  
      strMessage += "Ligne #{posLig+=1} #{tmp ? "bonne":"erronnée"}\n"
  
    end
    
    #puts "\nVérification des colonnes\n"
    posCol = 0
    for y in tabCol
      tmp = true
      if y.valide() == false then
        tmp = false
      end
      
      strMessage += "Colonne #{posCol+=1} #{tmp ? "bonne":"erronnée"}\n"
      
    end
  
    return strMessage
  
  end
  
end #marqueur de fin de classe
