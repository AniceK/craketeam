package interfacepicross;

import java.awt.Color;
import javax.swing.JPanel;

public class PixelVignette extends JPanel
{
  private RegleJeu regles;
  private Color col = Color.WHITE;
  private int x;
  private int y;

  public PixelVignette(int x, int y, Color c)
  {
    this.regles = RegleJeu.getInstance();
    this.x = x;
    this.y = y;
    this.col = c;
    initCase();
  }

  private void initCase()
  {
    setBackground(Color.WHITE);
  }

  public void changeEtat()
  {
    if (RegleJeu.isNoirEtBlancV())
    {
      this.col = Color.DARK_GRAY;
    }
    else
    {
      this.col = RegleJeu.getImgColor(this.x, this.y);
    }
    setBackground(this.col);
  }
}