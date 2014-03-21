package interfacepicross;

import java.awt.Color;
import java.awt.Graphics;

public class Croix
{
  private int width = 1;
  private int height = 1;
  private Color trait;

  public Croix(int w, int h, Color c)
  {
    this.width = w;
    this.height = h;
    this.trait = c;
  }

  public int getWidth()
  {
    return this.width;
  }

  public int getHeight()
  {
    return this.height;
  }

  public Color getColor()
  {
    return this.trait;
  }

  public void draw(Graphics G, int w, int h)
  {
    G.setColor(getColor());
    G.drawLine(0, 0, w, h);

    G.drawLine(1, 0, w + 1, h);
    G.drawLine(-1, 0, w - 1, h);

    G.drawLine(w, 0, 0, h);

    G.drawLine(w - 1, 0, -1, h);
    G.drawLine(w + 1, 0, 1, h);
  }
}