package interfacepicross;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Image;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.swing.BoxLayout;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class Manuel extends JFrame
{
  private Image icon;

  public Manuel()
  {
    fenetre();
  }

  private void fenetre()
  {
    setTitle("Manuel");

    File f = new File("icon.png");
    try
    {
      this.icon = ImageIO.read(f);
    }
    catch (IOException e) {
      e.printStackTrace();
    }

    setIconImage(this.icon);
    setPreferredSize(new Dimension(360, 420));
    setMinimumSize(new Dimension(240, 310));
    setResizable(true);
    pack();
    setLocationRelativeTo(null);
    setVisible(true);

    setLayout(new BorderLayout());

    JLabel info = new JLabel("<html><div style='text-align:center;'><strong style='font-size:18px;'>Comment jouer</strong><br/><br/>Dans ce jeu de <strong style='font-size:12px;'>Picross</strong>, il s'agit de remplir les grilles en suivant les instructions placées <strong style='font-size:11px;'>horizontalement</strong> et <strong style='font-size:11px;'>verticalement</strong>. <br/><br/>Par exemple, si on vous indique 5 en horizontal, cela veut donc dire qu'il faut remplir 5 cases <strong style='font-size:11px;'>consécutives</strong>. <br/><br/>Pour un tel exemple, c'est très simple dans une grille de 5x5, mais un peu plus complexe dans une grille de 10x10. <br/><br/>Vous pouvez placer des croix sur les cases dont vous êtes certain qu'il n'y a rien à remplir, histoire d'y voir plus clair pour le reste. <br/><br/><strong style='font-size:18px;'>Les Points</strong><br/><br/> <strong style='font-size:13px;'>+10</strong> : BONNE case<br/> <strong style='font-size:13px;'>-50</strong> : MAUVAISE case</div></html>");
    info.setHorizontalAlignment(0);

    JPanel all = new JPanel();
    all.setLayout(new BoxLayout(all, 1));
    all.add(info);

    add("North", all);
  }
}