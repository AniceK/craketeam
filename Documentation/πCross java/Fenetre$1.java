package interfacepicross;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

class 1
  implements ActionListener
{
  public void actionPerformed()
  {
    RegleJeu.changeImg(5);
    this.this$0.changerPlateau(RegleJeu.getPlateau());
  }
}