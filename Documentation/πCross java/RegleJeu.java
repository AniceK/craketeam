package interfacepicross;

import java.awt.Color;
import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Random;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

public class RegleJeu
{
  private static RegleJeu instance = null;
  private static PlateauJeu plateau = null;
  private static ImageJeu imgJeu = null;
  private static String[] tabStrCol = null;
  private static String[] tabStrLigne = null;
  private static int[] tabMaxCol = null;
  private static int[] tabMaxLigne = null;
  private static boolean[][] tabErreur = (boolean[][])null;
  private static boolean[][] tabActuel = (boolean[][])null;
  private static boolean noirEtBlanc = true;
  private static boolean noirEtBlancV = false;
  private static boolean gameEnd = false;
  private static int score = 0;
  private static int erreur = 0;
  private static int grille = 15;

  private RegleJeu()
  {
    changeImg(grille);
  }

  public static RegleJeu getInstance()
  {
    if (instance == null)
      instance = new RegleJeu();
    return instance;
  }

  private static int nbFic(String dir)
  {
    File directory = new File(dir);
    File[] f = directory.listFiles();

    int x = 0;
    for (int i = 0; i < f.length; ++i)
    {
      if (f[i].isFile()) ++x;
    }

    return x;
  }

  public static void changeImg(int taille)
  {
    int j;
    score = 0;
    erreur = 0;
    gameEnd = false;
    grille = taille;

    Random randomImage = new Random();
    int random = randomImage.nextInt(nbFic("img/" + grille + "x" + grille));

    String chemin = "img/" + grille + "x" + grille + "/" + random + ".bmp";
    try
    {
      imgJeu = new ImageJeu(chemin);
    }
    catch (IOException ex)
    {
      System.out.println("Image non trouvée\n");
    }

    tabErreur = new boolean[imgJeu.getWidth()][imgJeu.getWidth()];
    tabActuel = new boolean[imgJeu.getWidth()][imgJeu.getWidth()];
    tabStrCol = new String[imgJeu.getWidth()];
    tabMaxCol = new int[imgJeu.getWidth()];
    tabStrLigne = new String[imgJeu.getWidth()];
    tabMaxLigne = new int[imgJeu.getWidth()];

    int nb = 0;
    for (int i = 0; i < imgJeu.getWidth(); ++i)
    {
      nb = 0;
      tabStrCol[i] = "<html>";
      for (j = 0; j < imgJeu.getWidth(); ++j)
      {
        tabActuel[j][i] = 0;
        if (isCorrect(i, j))
        {
          ++nb;
        }
        else
        {
          tabErreur[j][i] = 1;
          if (nb != 0) {
            int tmp314_312 = i;
            String[] tmp314_309 = tabStrCol; tmp314_309[tmp314_312] = tmp314_309[tmp314_312] + String.valueOf(nb) + "<br/>";
          }
          tabMaxCol[i] += nb;
          nb = 0;
        }
      }
      if (nb != 0)
      {
        int tmp373_371 = i;
        String[] tmp373_368 = tabStrCol; tmp373_368[tmp373_371] = tmp373_368[tmp373_371] + String.valueOf(nb) + " ";
        tabMaxCol[i] += nb;
      }

      if (tabStrCol[i].equals("<html>")) {
        int tmp432_430 = i;
        String[] tmp432_427 = tabStrCol; tmp432_427[tmp432_430] = tmp432_427[tmp432_430] + "0"; }
      int tmp458_456 = i;
      String[] tmp458_453 = tabStrCol; tmp458_453[tmp458_456] = tmp458_453[tmp458_456] + "</html>";
    }

    for (i = 0; i < imgJeu.getWidth(); ++i)
    {
      nb = 0;
      tabStrLigne[i] = "<html>";
      for (j = 0; j < imgJeu.getWidth(); ++j)
      {
        if (isCorrect(j, i))
        {
          ++nb;
        }
        else
        {
          if (nb != 0) {
            int tmp550_548 = i;
            String[] tmp550_545 = tabStrLigne; tmp550_545[tmp550_548] = tmp550_545[tmp550_548] + String.valueOf(nb) + " ";
          }
          tabMaxLigne[i] += nb;
          nb = 0;
        }
      }
      if (nb != 0)
      {
        int tmp609_607 = i;
        String[] tmp609_604 = tabStrLigne; tmp609_604[tmp609_607] = tmp609_604[tmp609_607] + String.valueOf(nb) + " ";
        tabMaxLigne[i] += nb;
      }
      if (tabStrLigne[i].equals("<html>")) {
        int tmp668_666 = i;
        String[] tmp668_663 = tabStrLigne; tmp668_663[tmp668_666] = tmp668_663[tmp668_666] + "0"; }
      int tmp694_692 = i;
      String[] tmp694_689 = tabStrLigne; tmp694_689[tmp694_692] = tmp694_689[tmp694_692] + "</html>";
    }
  }

  public static boolean isCorrect(int x, int y)
  {
    boolean res = false;
    Color pixel = imgJeu.getPixel(x, y);
    if ((pixel.getBlue() != 255) || (pixel.getGreen() != 255) || (pixel.getRed() != 255))
    {
      res = true;
      tabErreur[y][x] = 0;
    }
    else
    {
      tabErreur[y][x] = 1;
    }

    return res;
  }

  public static void setCorrect(int x, int y)
  {
    plateau.updateVignette(x, y);
  }

  public static Color getImgColor(int x, int y)
  {
    return imgJeu.getPixel(x, y);
  }

  public static ImageJeu getImg()
  {
    return imgJeu;
  }

  public static int getScore()
  {
    return score;
  }

  public static int getErreur()
  {
    return erreur;
  }

  public static void decrementeScore()
  {
    score -= 50;
    if (score < 0)
      score = 0;
    plateau.setScore(score);
  }

  public static void augmenteScore()
  {
    score += 10;
    plateau.setScore(score);
  }

  public static void augmenteErreur()
  {
    erreur += 1;
    plateau.setScore(score);
  }

  public static void setPlateau(PlateauJeu p)
  {
    plateau = p;
  }

  public static PlateauJeu getPlateau()
  {
    return plateau;
  }

  public static boolean[][] getTabActuel()
  {
    return tabActuel;
  }

  public static String[] getInfoColonnes()
  {
    return tabStrCol;
  }

  public static String[] getInfoLignes()
  {
    return tabStrLigne;
  }

  public static int getMaxCol(int i)
  {
    return tabMaxCol[i];
  }

  public static int getMaxLigne(int i)
  {
    return tabMaxLigne[i];
  }

  public static void decrementeMaxCol(int i)
  {
    tabMaxCol[i] -= 1;
  }

  public static void decrementeMaxLigne(int i)
  {
    tabMaxLigne[i] -= 1;
  }

  public static void verifierLigneColonneComplete(int x, int y)
  {
    if (tabMaxCol[x] == 0)
      plateau.updateColonne(x);
    if (tabMaxLigne[y] == 0)
      plateau.updateLigne(y);
  }

  public static void verifierFinJeu()
  {
    gameEnd = true;
    for (int i = 0; i < imgJeu.getWidth(); ++i)
    {
      if (tabMaxCol[i] != 0)
      {
        gameEnd = false;
      }
    }

    for (int j = 0; j < imgJeu.getWidth(); ++j)
    {
      if (tabMaxLigne[j] != 0)
      {
        gameEnd = false;
      }
    }

    if (gameEnd)
    {
      JOptionPane.showMessageDialog(new JFrame(), "<html>Vous avez <strong style='font-size:12px;'>GAGNE</strong><br/> Vous pouvez faire une nouvelle partie en allant dans le menu 'Jeu'</html>", "Fin de la partie", 1);
    }
  }

  public static boolean isFinJeu()
  {
    return gameEnd;
  }

  public static boolean isNoirEtBlanc()
  {
    return noirEtBlanc;
  }

  public static boolean isNoirEtBlancV()
  {
    return noirEtBlancV;
  }

  public static void setNoirEtBlanc()
  {
    if (noirEtBlanc)
    {
      noirEtBlanc = false;
    }
    else
    {
      noirEtBlanc = true;
    }
    plateau.updateColor();
  }

  public static void setNoirEtBlancV()
  {
    if (noirEtBlancV)
    {
      noirEtBlancV = false;
    }
    else
    {
      noirEtBlancV = true;
    }
    plateau.updateColorV();
  }
}