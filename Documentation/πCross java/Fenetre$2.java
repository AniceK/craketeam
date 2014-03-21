package interfacepicross;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

class 2
  implements ActionListener
{
  public void actionPerformed()
  {
    RegleJeu.changeImg(10);
    this.this$0.changerPlateau(RegleJeu.getPlateau());
  }
}