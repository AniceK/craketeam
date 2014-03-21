package interfacepicross;

import java.awt.Container;
import java.awt.Dimension;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import javax.accessibility.AccessibleContext;
import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.KeyStroke;

public class Fenetre extends JFrame
{
  private RegleJeu regles;
  private static PlateauJeu plateau = null;
  private JMenuBar menuBar = null;
  private Image icon = null;

  public Fenetre()
  {
    init();
    this.regles = RegleJeu.getInstance();

    File f = new File("icon.png");
    try
    {
      this.icon = ImageIO.read(f);
    }
    catch (IOException e) {
      e.printStackTrace();
    }
    setIconImage(this.icon);

    ajouterMenu();

    plateau = new PlateauJeu();
    ajouterPlateau(plateau);
    setVisible(true);
  }

  private void init()
  {
    setTitle("πCross - Par GROSLEVIN Rémi et QUILFEN Anthony Groupe C1");
    setPreferredSize(new Dimension(720, 740));
    setMinimumSize(new Dimension(580, 670));
    setDefaultCloseOperation(3);
    setResizable(true);
    pack();
    setLocationRelativeTo(null);
  }

  private void ajouterMenu()
  {
    this.menuBar = new JMenuBar();

    JMenu menu = new JMenu("Jeu");
    menu.getAccessibleContext().setAccessibleDescription("Jeu");
    this.menuBar.add(menu);

    JMenuItem newGrid5x5 = new JMenuItem("5x5 - Nouvelle Grille", 78);
    newGrid5x5.setAccelerator(KeyStroke.getKeyStroke(49, 2));
    newGrid5x5.getAccessibleContext().setAccessibleDescription("Nouvelle grille 5x5");
    newGrid5x5.addActionListener(new ActionListener(this)
    {
      public void actionPerformed() {
        RegleJeu.changeImg(5);
        this.this$0.changerPlateau(RegleJeu.getPlateau());
      }

    });
    menu.add(newGrid5x5);

    JMenuItem newGrid10x10 = new JMenuItem("10x10 - Nouvelle Grille", 78);
    newGrid10x10.setAccelerator(KeyStroke.getKeyStroke(50, 2));
    newGrid10x10.getAccessibleContext().setAccessibleDescription("Nouvelle grille 10x10");
    newGrid10x10.addActionListener(new ActionListener(this)
    {
      public void actionPerformed() {
        RegleJeu.changeImg(10);
        this.this$0.changerPlateau(RegleJeu.getPlateau());
      }

    });
    menu.add(newGrid10x10);

    JMenuItem newGrid15x15 = new JMenuItem("15x15 - Nouvelle Grille", 78);
    newGrid15x15.setAccelerator(KeyStroke.getKeyStroke(51, 2));
    newGrid15x15.getAccessibleContext().setAccessibleDescription("Nouvelle grille 15x15");
    newGrid15x15.addActionListener(new ActionListener(this)
    {
      public void actionPerformed() {
        RegleJeu.changeImg(15);
        this.this$0.changerPlateau(RegleJeu.getPlateau());
      }

    });
    menu.add(newGrid15x15);

    JMenuItem newGrid20x20 = new JMenuItem("20x20 - Nouvelle Grille", 78);
    newGrid20x20.setAccelerator(KeyStroke.getKeyStroke(52, 2));
    newGrid20x20.getAccessibleContext().setAccessibleDescription("Nouvelle grille 20x20");
    newGrid20x20.addActionListener(new ActionListener(this)
    {
      public void actionPerformed() {
        RegleJeu.changeImg(20);
        this.this$0.changerPlateau(RegleJeu.getPlateau());
      }

    });
    menu.add(newGrid20x20);

    JMenuItem exitGame = new JMenuItem("Quitter", 81);
    exitGame.setAccelerator(KeyStroke.getKeyStroke(81, 2));
    exitGame.getAccessibleContext().setAccessibleDescription("Quitter");
    exitGame.addActionListener(new ActionListener(this)
    {
      public void actionPerformed() {
        System.exit(0);
      }

    });
    menu.add(exitGame);

    menu = new JMenu("Options");
    menu.getAccessibleContext().setAccessibleDescription("Options");
    this.menuBar.add(menu);

    JMenuItem colors = new JMenuItem("Couleurs/Noir & Blanc - Jeu", 74);
    colors.setAccelerator(KeyStroke.getKeyStroke(74, 2));
    colors.getAccessibleContext().setAccessibleDescription("Couleurs/Noir & Blanc - Jeu");
    colors.addActionListener(new ActionListener(this)
    {
      public void actionPerformed() {
        RegleJeu.setNoirEtBlanc();
      }

    });
    menu.add(colors);

    JMenuItem colorsV = new JMenuItem("Couleurs/Noir & Blanc - Vignette", 86);
    colorsV.setAccelerator(KeyStroke.getKeyStroke(86, 2));
    colorsV.getAccessibleContext().setAccessibleDescription("Couleurs/Noir & Blanc - Vignette");
    colorsV.addActionListener(new ActionListener(this)
    {
      public void actionPerformed() {
        RegleJeu.setNoirEtBlancV();
      }

    });
    menu.add(colorsV);

    menu = new JMenu("Aide");
    menu.getAccessibleContext().setAccessibleDescription("Aide");
    this.menuBar.add(menu);

    JMenuItem manuel = new JMenuItem("Manuel", 77);
    manuel.setAccelerator(KeyStroke.getKeyStroke(77, 2));
    manuel.getAccessibleContext().setAccessibleDescription("Manuel");
    manuel.addActionListener(new ActionListener(this)
    {
      public void actionPerformed() {
        new Manuel();
      }

    });
    menu.add(manuel);

    JMenuItem APropos = new JMenuItem("A propos", 65);
    APropos.setAccelerator(KeyStroke.getKeyStroke(65, 2));
    APropos.getAccessibleContext().setAccessibleDescription("A propos");
    APropos.addActionListener(new ActionListener(this)
    {
      public void actionPerformed() {
        JOptionPane.showMessageDialog(new JFrame(), "<html><p style='font-size:16px;'><img src=\"file:footer.png\"> <br/> π<span style='font-size:11px;'>CROSS</span></p> <hr/><small>Date de création : 2012 <br/>Auteurs :  Rémi GROSLEVIN et Anthony \"Spownik\" QUILFEN <br/>Site web :  <a href='http://www.spownik.net'>www.spownik.net</a> <br/>Version : 1.0</small> <br/><br/> </html>", "A Propos", 1);
      }

    });
    menu.add(APropos);

    setJMenuBar(this.menuBar);
  }

  private void ajouterPlateau(PlateauJeu p)
  {
    plateau = p;

    Container cp = getContentPane();
    cp.add("Center", plateau);
  }

  public void changerPlateau(PlateauJeu p)
  {
    Container cp = getContentPane();
    cp.remove(plateau);

    plateau = new PlateauJeu();
    cp.add("Center", plateau);

    cp.validate();
  }
}