package interfacepicross;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

public class ImageJeu
{
  private BufferedImage img;
  private int w = 1;
  private int h = 1;

  public ImageJeu(String chemin)
    throws IOException
  {
    this.img = ImageIO.read(new File(chemin));
    this.w = this.img.getWidth();
    this.h = this.img.getHeight();
  }

  public int getWidth()
  {
    return this.w;
  }

  public int getHeight()
  {
    return this.h;
  }

  public Color getPixel(int pX, int pY)
  {
    int[] tabRGB = new int[3];
    this.img.getRaster().getPixel(pX, pY, tabRGB);
    Color res = new Color(tabRGB[0], tabRGB[1], tabRGB[2]);

    return res;
  }
}