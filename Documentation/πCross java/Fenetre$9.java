package interfacepicross;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

class 9
  implements ActionListener
{
  public void actionPerformed()
  {
    JOptionPane.showMessageDialog(new JFrame(), "<html><p style='font-size:16px;'><img src=\"file:footer.png\"> <br/> π<span style='font-size:11px;'>CROSS</span></p> <hr/><small>Date de création : 2012 <br/>Auteurs :  Rémi GROSLEVIN et Anthony \"Spownik\" QUILFEN <br/>Site web :  <a href='http://www.spownik.net'>www.spownik.net</a> <br/>Version : 1.0</small> <br/><br/> </html>", "A Propos", 1);
  }
}