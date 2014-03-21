package interfacepicross;

import java.io.File;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

public class InterfacePicross
{
  public static void main(String[] args)
  {
    Fenetre laVue;
    File f = new File("img");

    if (f.exists()) {
      laVue = new Fenetre();
    }
    else {
      JOptionPane.showMessageDialog(new JFrame(), "<html>Dossier <strong style='font-size:11px;'>\"img/\"</strong> introuvable. Aucune images disponibles, le jeu n'a pas pu démarrer !</html>", "Rapport d'erreur", 0);
      System.exit(0);
    }
  }
}