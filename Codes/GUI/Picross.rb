# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

class Builder < Gtk::Builder
  
  # => Permet d'afficher le contenu d'un utilisateur connecté
  @@profil = false
  # => Contiendra le pseudo de l'utilisateur à enregistrer
  @@pseudo = ""

  ##################################################################
  #                         Initialisation                         #
  ##################################################################
  
  def initialize 
    super()
    
    @src
    @dst
    
    self.add_from_file(__FILE__.sub(".rb",".glade"))
    
    self['Accueil'].show_all
    
    # Creation d'une variable d'instance par composant glade
    self.objects.each() { |p|
      #puts "Création d\'une variable d\'instance : '@#{p.builder_name}'"
      instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name])
    }
    puts " "
    self.connect_signals(){ |handler| 
      #puts "Connection d\'un signal à la methode : '#{handler}'"
      method(handler) 
    }

  end
  
  ##################################################################
  #                            Fonctions                           #
  ##################################################################
  
  ### Adaptation des fenêtres pour le profil ###
  def fenetreProfil()
    # => L'accueil devient celui du profil
    if @src == "Accueil" then @src = "AccueilProfil" end
    if @dst == "Accueil" then @dst = "AccueilProfil" end
      
    # => La pause devient celle du profil
    if @src == "Pause" then @src = "PauseProfil" end
    if @dst == "Pause" then @dst = "PauseProfil" end
      
    # => Le retour de la selection de taille vers le choix de partie
    if @src == "SelectionTaille" then
      if @dst == "AccueilProfil" then @dst = "ChoixPartie" end
    end
  end
  
  ### Déplacement d'une fenêtre à l'autre ###
  def mouvement(s, d)
    @src = s
    @dst = d
    
    # => Si un profil est chargé, on adapte les fenêtres à afficher
    if @@profil then fenetreProfil() end
      
    puts "Mouvement " + @src + " vers " + @dst
    self[@dst].show
    self[@src].hide
  end
  
  ### Enregistrement du nouveau pseudo chargé ou créé ###
  def newProfil
    @@profil = true
    @@pseudo = @entreePseudo.text
    print "Pseudo: " + @@pseudo + "\n"
    self['AccueilProfil'].set_title('Accueil - ' + @@pseudo)
  end
  
  ## Création d'une grille de taille fournie en paramètre
  def creationGrille(size)
    @grilleJeu.n_rows = size;
    @grilleJeu.n_columns = size;
    @conditionsH.n_rows = size;
    @conditionsH.n_columns = size;
    @conditionsH.n_rows = size;
    @conditionsH.n_columns = size;
    
    @grilleJeu.attach_defaults(Gtk::Button.new(''), 0,1,0,1)
    @grilleJeu.attach_defaults(Gtk::Button.new(''), 0,1,1,2)
  end
  
  ##################################################################
  #                         Fermeture fenêtre                      #
  ##################################################################
  
  ### Fin de l'exécution ###
  def gtk_main_quit         
    puts "Fermeture fenêtre !"
    Gtk.main_quit
  end
  
  ##################################################################
  #                             Accueil                            #
  ##################################################################

  def on_partieRapide_clicked
    mouvement("Accueil", "SelectionTaille")
  end
  
  ### Envoi vers Choix de Partie ###
  def on_jouer_clicked
    mouvement("Accueil", "ChoixPartie")
  end
  
  def on_editeur_clicked
    mouvement("Accueil", "Editeur")
  end
   
  ### Envoi vers Profil ###
  def on_profil_clicked         
    mouvement("Accueil", "Profil")
  end
  
  ### Envoi vers Options ###
  def on_options_clicked
    mouvement("Accueil", "Options")
  end
  
  ### Envoi vers Crédits ###
  def on_credits_clicked         
    mouvement("Accueil", "Credits")
  end
  
  ### Déconnexion ###
  def on_deconnexion_clicked
    @@profil = false
    mouvement("AccueilProfil", "Accueil")
  end
  
  ##################################################################
  #                        Choix de Partie                         #
  ##################################################################
  
  ### Envoi vers sélection de taille ###
  def on_nouvellePartie_clicked
    mouvement("ChoixPartie", "SelectionTaille")
  end
  
  def on_chargerPartie_clicked
    mouvement("ChoixPartie", "ChargerSauvegarde")
  end
  
  def on_choixPartieBack_clicked         
    mouvement("ChoixPartie", "Accueil")
  end
  
  ##################################################################
  #                        Modes de Jeu                         #
  ##################################################################
  
  def on_classique_clicked
    mouvement("ModeDeJeu", "SelectionTaille")
  end
  
  def on_modeDeJeuBack_clicked
    mouvement("ModeDeJeu", "ChoixPartie")
  end
  
  ##################################################################
  #                      Sélection de taille                       #
  ##################################################################
  
  def on_selectionTailleBack_clicked         
    mouvement("SelectionTaille", "Accueil")
  end
  
  def on_size5x5_clicked
    creationGrille(5)
    mouvement("SelectionTaille", "ChoixGrille")
  end
  
  def on_size10x10_clicked
    creationGrille(10)
    mouvement("SelectionTaille", "ChoixGrille")
  end
  
  ##################################################################
  #                         Choix de Grille                        #
  ##################################################################
  
  def on_choixGrilleBack_clicked         
    mouvement("ChoixGrille", "SelectionTaille")
  end
  
  def on_grilleExistante_clicked
    mouvement("ChoixGrille", "ChoixGrilleExistante")
  end
  
  def on_grilleAleatoire_clicked
    mouvement("ChoixGrille", "Jeu")
  end
  
  ##################################################################
  #                    Choix de Grille Existante                   #
  ##################################################################
  
  def on_choixGrilleExistanteBack_clicked         
    mouvement("ChoixGrilleExistante", "ChoixGrille")
  end
  
  def on_validerChoixGrilleExistante_clicked         
    mouvement("ChoixGrilleExistante", "Jeu")
  end
  
  ##################################################################
  #                     Charger une Sauvegarde                     #
  ##################################################################
  
  def on_chargerBack_clicked
    mouvement("ChargerSauvegarde", "ChoixPartie")
  end
  
  def on_choixSauvegarde_clicked
    mouvement("ChargerSauvegarde", "Jeu")
  end
  
  ##################################################################
  #                              Jeu                               #
  ##################################################################
  
  def on_menuJeu_clicked
    mouvement("Jeu", "Pause")
  end
  
  def on_aideJeu_clicked
    mouvement("Jeu", "JeuFin")
  end
  
  ##################################################################
  #                             Pause                              #
  ##################################################################
  
  def on_continuePause_clicked
    mouvement("Pause", "Jeu")
  end
  
  def on_sauvegardePause_clicked
    # => Si nom de sauvegarde correct
    puts "Partie sauvegardée ! ==> " + @entreeSauvegarde.text
    mouvement("Pause", "Accueil")
  end
  
  def on_pauseToAccueil_clicked
    mouvement("Pause", "Accueil")
  end
  
  ##################################################################
  #                          Jeu terminé                           #
  ##################################################################
  
  def on_recommencePartie_clicked
    mouvement("JeuFin", "SelectionTaille")
  end
  
  ##################################################################
  #                            Editeur                             #
  ##################################################################
  
  def on_editeurBack_clicked
    mouvement("Editeur", "Accueil")
  end
  
  ##################################################################
  #                             Profil                             #
  ##################################################################
  
  def on_profilBack_clicked         
    mouvement("Profil", "Accueil")
  end
  
  def on_creerProfil_clicked
    # => Si nouveau pseudo
    newProfil() 
    mouvement("Profil", "AccueilProfil")
    
    # => Sinon
    # Pop-up Erreur: Nom existant ou invalide
  end
  
  def on_chargerProfil_clicked
    # => Si profil existant
    newProfil()
    mouvement("Profil", "AccueilProfil")
    
    # => Sinon
    # Pop-up Erreur: Nom inexistant ou invalide
  end
  
  ##################################################################
  #                            Options                             #
  ##################################################################
  
  def on_optionsBack_clicked
    mouvement("Options", "Accueil")
  end
  
  ##################################################################
  #                            Crédits                             #
  ##################################################################
  
  def on_creditsBack_clicked         
    mouvement("Credits", "Accueil")
  end
  
end

  ##################################################################
  #                           Exécution                            #
  ##################################################################

 Gtk.init
 builder = Builder.new()
 puts "Lancement de l'application"
 Gtk.main