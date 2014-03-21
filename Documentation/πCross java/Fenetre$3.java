package interfacepicross;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

class 3
  implements ActionListener
{
  public void actionPerformed()
  {
    RegleJeu.changeImg(15);
    this.this$0.changerPlateau(RegleJeu.getPlateau());
  }
}