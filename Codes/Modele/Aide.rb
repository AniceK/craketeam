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
    
    @tabCondCol.clear()
    @tabCondLig.clear()
    
    tabCol.each{ |x|
      @tabCondCol.push(x.conditions)
    }
    
    tabLig.each{ |x|
      @tabCondLig.push(x.conditions)
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
      for col in tabCondCol
        totalCol = 0
      
        for valCol in col 
          totalCol += valCol
        end
        
        #puts "Total de la colonne #{pos} : #{totalCol}"
      
        if(tabCol[pos-1].valide == false) then
      
            if totalCol == tabTaille then
              if difficulte == 1
                strMessage += "Colonne #{pos} : pleine\n"
              else
                strMessage += "Colonne #{pos}\n" 
              end
        
            elsif col.count > tabTaille/2 && tabTaille%2 == 1
              if difficulte == 1
                strMessage += "Colonne #{pos} : une case sur deux en partant du bord\n"
              else
                strMessage += "Colonne #{pos}\n"
              end
              
          elsif totalCol > tabTaille/2 && col.count > 1
              if difficulte == 1
                  #puts "valeur col.max #{col.max} - tabTaille #{tabTaille} - totalCol #{totalCol} - col.count #{col.count}"
                  strMessage += "Colonne #{pos} : #{col.max() - (tabTaille - (totalCol + col.count - 1))} case#{(col.max() - (tabTaille - (totalCol + col.count - 1))>1 ? "s":"")} à colorier\n"
              else
                  strMessage += "Colonne #{pos}\n"
              end
        
            elsif col.count == 1 && totalCol > tabTaille/2 
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
            
            elsif totalCol == tabTaille - (col.count - 1)
              if difficulte == 1
                strMessage += "Colonne #{pos} : 1 case blanche entre chaque condition\n"
              else
                strMessage += "Colonne #{pos}\n"
              end
          
              if difficulte == 1
                  #strMessage += "Colonne #{pos}: aucune aide disponible\n"
              end
            end
      
        else
            strMessage += "Colonne #{pos} : valide\n"
        end
        
        pos += 1
      end
    
      #====      Ligne     ====#
    
    
      pos = 1
    
      strMessage += "\nCondition des lignes\n"
      for lig in tabCondLig
        totalLig = 0
      
        for valLig in lig 
          totalLig += valLig
        end
      
        #puts "Total de la ligne #{pos} : #{totalLig}"
      
      if(tabLig[pos-1].valide == false) then
        
        if totalLig == tabTaille then
          if difficulte == 1
            strMessage += "Ligne #{pos} : pleine\n"
        
          else
            strMessage += "Ligne #{pos}\n"
          end
        
        elsif lig.count > tabTaille/2 && tabTaille%2 == 1
          if difficulte == 1
            strMessage += "Ligne #{pos} : une case sur deux est noir en partant du bord\n"
          
          else
            strMessage += "Ligne #{pos}\n"
          end
          
      elsif totalLig > tabTaille/2 && lig.count > 1
          if difficulte == 1
              #puts "valeur lig.max #{lig.max} - (tabTaille #{tabTaille} - (totalLig #{totalLig} + lig.count #{lig.count-1}))) = #{lig.max() - (tabTaille - (totalLig + (lig.count) - 1))}"
              strMessage += "Ligne #{pos} : #{lig.max() - (tabTaille - (totalLig + lig.count - 1))} case#{(lig.max() - (tabTaille - (totalLig + lig.count - 1))>1 ? "s":"")} à colorier\n"
          else
              strMessage += "Ligne #{pos}\n"
          end
        
        elsif lig.count == 1 && totalLig > tabTaille/2
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
          
        elsif totalLig == tabTaille - (lig.count - 1)
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
        
        else
            strMessage += "Ligne #{pos} : valide\n"
        end
      
        pos += 1
      end
    end
    
  
    return strMessage
  
  end
  
end #marqueur de fin de classe
