package interfacepicross;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridLayout;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class PlateauJeu extends JPanel
{
  private RegleJeu regles;
  private CaseJeu[][] cases = (CaseJeu[][])null;
  private PixelVignette[][] pixels = (PixelVignette[][])null;
  private int decVignette = 128;
  private int imgSize = 1;
  private JLabel score;
  private JLabel[] infoColonnes = null;
  private JLabel[] infoLignes = null;

  public PlateauJeu()
  {
    RegleJeu.setPlateau(this);
    if (RegleJeu.getImg().getWidth() >= RegleJeu.getImg().getHeight())
      this.imgSize = RegleJeu.getImg().getWidth();
    else {
      this.imgSize = RegleJeu.getImg().getHeight();
    }

    this.cases = new CaseJeu[this.imgSize][this.imgSize];
    this.pixels = new PixelVignette[this.imgSize][this.imgSize];
    this.infoColonnes = new JLabel[this.imgSize];
    this.infoLignes = new JLabel[this.imgSize];

    this.decVignette = (12 * this.imgSize);
    initComposants();
  }

  private void initComposants()
  {
    setLayout(new BorderLayout());

    JPanel pnlSuperieur = new JPanel();
    pnlSuperieur.setLayout(new BorderLayout());

    JPanel pnlSuperieurVignette = new JPanel();
    pnlSuperieurVignette.setLayout(new BoxLayout(pnlSuperieurVignette, 1));
    pnlSuperieurVignette.add(Box.createRigidArea(new Dimension(this.decVignette, 0)));

    JPanel pnlVignette = new JPanel();
    pnlVignette.setLayout(new BoxLayout(pnlVignette, 1));

    JPanel vignette = new JPanel();
    vignette.setLayout(new GridLayout(this.imgSize, this.imgSize));
    for (int i = 0; i < this.imgSize; ++i)
    {
      for (int j = 0; j < this.imgSize; ++j)
      {
        this.pixels[j][i] = new PixelVignette(j, i, RegleJeu.getImgColor(j, i));
        vignette.add(this.pixels[j][i]);
      }
    }

    pnlVignette.add(vignette);

    JPanel pnlSuperieurGrid = new JPanel();
    pnlSuperieurGrid.setLayout(new GridLayout(1, this.imgSize));
    for (int i = 0; i < this.imgSize; ++i)
    {
      this.infoColonnes[i] = new JLabel(RegleJeu.getInfoColonnes()[i]);
      this.infoColonnes[i].setHorizontalAlignment(0);
      this.infoColonnes[i].setVerticalAlignment(3);
      if (RegleJeu.getMaxCol(i) == 0)
        this.infoColonnes[i].setForeground(Color.LIGHT_GRAY);
      pnlSuperieurGrid.add(this.infoColonnes[i]);
    }

    JPanel pnlSuperieurDroite = new JPanel();
    pnlSuperieurDroite.setLayout(new BoxLayout(pnlSuperieurDroite, 0));
    pnlSuperieurDroite.add(Box.createRigidArea(new Dimension(0, this.decVignette)));

    JPanel pnlGauche = new JPanel();
    pnlGauche.setLayout(new BoxLayout(pnlGauche, 1));
    pnlGauche.add(Box.createRigidArea(new Dimension(this.decVignette, 0)));

    JPanel pnlGaucheGrid = new JPanel();
    pnlGaucheGrid.setLayout(new GridLayout(this.imgSize, 1));
    for (int i = 0; i < this.imgSize; ++i)
    {
      this.infoLignes[i] = new JLabel(RegleJeu.getInfoLignes()[i]);
      this.infoLignes[i].setHorizontalAlignment(4);
      this.infoLignes[i].setVerticalAlignment(0);
      if (RegleJeu.getMaxLigne(i) == 0)
        this.infoLignes[i].setForeground(Color.LIGHT_GRAY);
      pnlGaucheGrid.add(this.infoLignes[i]);
    }

    JPanel pnlCentral = new JPanel();
    pnlCentral.setLayout(new GridLayout(this.imgSize, this.imgSize));

    for (int i = 0; i < this.imgSize; ++i)
    {
      for (int j = 0; j < this.imgSize; ++j)
      {
        this.cases[j][i] = new CaseJeu(j, i);
        if (RegleJeu.isCorrect(j, i))
        {
          this.cases[j][i].changeEtat(CaseJeu.Etat.BLANC);
        }
        pnlCentral.add(this.cases[j][i]);
      }

    }

    JPanel pnlScore = new JPanel();
    pnlScore.setLayout(new BorderLayout());

    this.score = new JLabel("<html><hr/> <big>Score " + RegleJeu.getScore() + " <span style='color:0075FF;'>Erreur(s) " + RegleJeu.getErreur() + "</span> </big> </html>");
    pnlScore.add("West", this.score);

    JLabel footer = new JLabel("<html><img src=\"file:footer.png\"></html>");
    pnlScore.add("East", footer);

    add("North", pnlSuperieur);
    pnlSuperieur.add("Center", pnlSuperieurGrid);
    pnlSuperieur.add("West", pnlSuperieurVignette);
    pnlSuperieur.add("East", pnlSuperieurDroite);
    pnlSuperieurVignette.add(pnlVignette);
    pnlGauche.add(pnlGaucheGrid);
    add("West", pnlGauche);
    add("Center", pnlCentral);
    add("South", pnlScore);
  }

  public void setScore(int s)
  {
    this.score.setText("<html><hr/> <big>Score " + RegleJeu.getScore() + " <span style='color:0075FF;'>Erreur(s) " + RegleJeu.getErreur() + "</span> </big> </html>");
  }

  public void updateVignette(int x, int y)
  {
    RegleJeu.getTabActuel()[x][y] = 1;
    this.pixels[x][y].changeEtat();
  }

  public void updateColonne(int x)
  {
    this.infoColonnes[x].setForeground(Color.LIGHT_GRAY);
  }

  public void updateLigne(int y)
  {
    this.infoLignes[y].setForeground(Color.LIGHT_GRAY);
  }

  public void updateColor()
  {
    for (int i = 0; i < this.imgSize; ++i)
    {
      for (int j = 0; j < this.imgSize; ++j)
      {
        if (RegleJeu.getTabActuel()[j][i] != 0)
        {
          Color col;
          if (RegleJeu.isNoirEtBlanc())
          {
            col = Color.DARK_GRAY;
          }
          else
          {
            col = RegleJeu.getImgColor(j, i);
          }

          this.cases[j][i].setBackground(col);
        }
      }
    }
  }

  public void updateColorV()
  {
    for (int i = 0; i < this.imgSize; ++i)
    {
      for (int j = 0; j < this.imgSize; ++j)
      {
        if (RegleJeu.getTabActuel()[j][i] != 0)
        {
          Color col;
          if (RegleJeu.isNoirEtBlancV())
          {
            col = Color.DARK_GRAY;
          }
          else
          {
            col = RegleJeu.getImgColor(j, i);
          }
          this.pixels[j][i].setBackground(col);
        }
      }
    }
  }
}