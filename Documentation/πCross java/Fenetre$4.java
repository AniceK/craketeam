package interfacepicross;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

class 4
  implements ActionListener
{
  public void actionPerformed()
  {
    RegleJeu.changeImg(20);
    this.this$0.changerPlateau(RegleJeu.getPlateau());
  }
}