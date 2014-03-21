package interfacepicross;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.BorderFactory;
import javax.swing.JPanel;
import javax.swing.border.Border;

public class CaseJeu extends JPanel
{
  private RegleJeu regles;
  private int x;
  private int y;
  private Color col = Color.WHITE;
  private Croix croix = null;
  private boolean affiGrid = true;

  public CaseJeu(int x, int y)
  {
    this.regles = RegleJeu.getInstance();
    this.x = x;
    this.y = y;
    setToolTipText("Case (" + String.valueOf(x) + ", " + String.valueOf(y) + ")");
    initCase();
  }

  private void initCase()
  {
    setBackground(this.col);

    Color tmpCol = Color.GRAY;

    if (this.affiGrid)
    {
      tmpCol = Color.GRAY;

      if (this.y % 5 == 0) tmpCol = Color.BLACK;
      Border bdrUp = BorderFactory.createMatteBorder(1, 0, 0, 0, tmpCol);

      tmpCol = Color.GRAY;
      if (this.x % 5 == 0) tmpCol = Color.BLACK;
      Border bdrRight = BorderFactory.createMatteBorder(0, 1, 0, 0, tmpCol);

      tmpCol = Color.GRAY;
      if (this.y % 5 == 4) tmpCol = Color.BLACK;
      Border bdrDown = BorderFactory.createMatteBorder(0, 0, 1, 0, tmpCol);

      tmpCol = Color.GRAY;
      if (this.x % 5 == 4) tmpCol = Color.BLACK;
      Border bdrLeft = BorderFactory.createMatteBorder(0, 0, 0, 1, tmpCol);

      Border bdrUR = BorderFactory.createCompoundBorder(bdrUp, bdrRight);
      Border bdrDL = BorderFactory.createCompoundBorder(bdrDown, bdrLeft);
      Border bdrAll = BorderFactory.createCompoundBorder(bdrDL, bdrUR);

      setBorder(bdrAll);
    }
    else
    {
      setBorder(BorderFactory.createMatteBorder(1, 1, 1, 1, tmpCol));
    }

    addMouseListener(new MouseAdapter(this)
    {
      public void mousePressed()
      {
        CaseJeu.access$000(this.this$0, e);
      }

      public void mouseEntered()
      {
        CaseJeu.access$100(this.this$0);
      }

      public void mouseExited()
      {
        CaseJeu.access$200(this.this$0);
      }
    });
  }

  private void caseUnselect()
  {
    Color tmpCol = Color.GRAY;

    if (this.affiGrid)
    {
      tmpCol = Color.GRAY;
      if (this.y % 5 == 0) tmpCol = Color.BLACK;
      Border bdrUp = BorderFactory.createMatteBorder(1, 0, 0, 0, tmpCol);

      tmpCol = Color.GRAY;
      if (this.x % 5 == 0) tmpCol = Color.BLACK;
      Border bdrRight = BorderFactory.createMatteBorder(0, 1, 0, 0, tmpCol);

      tmpCol = Color.GRAY;
      if (this.y % 5 == 4) tmpCol = Color.BLACK;
      Border bdrDown = BorderFactory.createMatteBorder(0, 0, 1, 0, tmpCol);

      tmpCol = Color.GRAY;
      if (this.x % 5 == 4) tmpCol = Color.BLACK;
      Border bdrLeft = BorderFactory.createMatteBorder(0, 0, 0, 1, tmpCol);

      Border bdrUR = BorderFactory.createCompoundBorder(bdrUp, bdrRight);
      Border bdrDL = BorderFactory.createCompoundBorder(bdrDown, bdrLeft);
      Border bdrAll = BorderFactory.createCompoundBorder(bdrDL, bdrUR);

      setBorder(bdrAll);
    }
    else
    {
      setBorder(BorderFactory.createMatteBorder(1, 1, 1, 1, tmpCol));
    }
  }

  private void caseSelect()
  {
    setBorder(BorderFactory.createLineBorder(Color.BLUE));
  }

  private void caseClick(MouseEvent e)
  {
    int btnClicked = e.getButton();

    if ((btnClicked == 1) && (!(RegleJeu.isFinJeu())))
    {
      changeEtat(Etat.NOIR);
    }
    else if ((btnClicked == 3) && (!(RegleJeu.isFinJeu())))
    {
      changeEtat(Etat.COCHE);
    }
  }

  public void changeEtat(Etat e)
  {
    switch (2.$SwitchMap$interfacepicross$CaseJeu$Etat[e.ordinal()])
    {
    case 1:
      if ((this.croix != null) || (getBackground() != Color.WHITE)) return;

      if (RegleJeu.isCorrect(this.x, this.y))
      {
        if (RegleJeu.isNoirEtBlanc())
        {
          this.col = Color.DARK_GRAY;
        }
        else
        {
          this.col = RegleJeu.getImgColor(this.x, this.y);
        }

        RegleJeu.decrementeMaxCol(this.x);
        RegleJeu.decrementeMaxLigne(this.y);

        RegleJeu.verifierLigneColonneComplete(this.x, this.y);

        setBackground(this.col);
        RegleJeu.setCorrect(this.x, this.y);
        RegleJeu.augmenteScore();
        RegleJeu.verifierFinJeu(); return;
      }

      this.col = Color.WHITE;
      setBackground(this.col);
      Croix cRouge = new Croix(getWidth(), getHeight(), Color.RED);
      this.croix = cRouge;
      this.croix.draw(getGraphics(), getWidth(), getHeight());
      RegleJeu.decrementeScore();
      RegleJeu.augmenteErreur();
      break;
    case 2:
      if ((this.croix == null) && (getBackground() == Color.WHITE))
      {
        this.col = Color.WHITE;
        setBackground(this.col);

        Croix cNoire = new Croix(getWidth(), getHeight(), Color.BLACK);
        this.croix = cNoire;
        this.croix.draw(getGraphics(), getWidth(), getHeight());
        return; }
      if ((this.croix == null) || (this.croix.getColor() == Color.RED)) return;

      this.croix = null;
      paintComponent(getGraphics()); break;
    default:
      this.col = Color.WHITE;
      setBackground(this.col);
    }
  }

  public void paintComponent(Graphics g)
  {
    super.paintComponent(g);
    if (this.croix != null)
      this.croix.draw(g, getWidth(), getHeight());
  }

  public static enum Etat
  {
    BLANC, NOIR, COCHE;
  }
}