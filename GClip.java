
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.ClipboardOwner;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.Transferable;
import java.util.ArrayList;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.io.Reader;
import java.io.StringReader;
import java.io.InputStream;
import java.io.StringBufferInputStream;

public class GClip implements ClipboardOwner {
  private static GClip gclip = null;
  private Clipboard clipboard = null;
  public static boolean copy(String chars) {
    if (gclip == null)
      gclip = new GClip();
    return gclip.copyString(chars);
  }
  private GClip() {
    if (clipboard == null) {
      makeClipboardObject();
    }
  }
  private void makeClipboardObject() {
    SecurityManager security = System.getSecurityManager();
    if (security != null) {
      try {
        security.checkSystemClipboardAccess();
        clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
      }
      catch (SecurityException e) {
        clipboard = new Clipboard("Application Clipboard");
      }
    } else {
      try {
        clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
      }
      catch (Exception e) {
        // THIS IS DUMB - true but is there another way - I think not
      }
    }
  }
  private boolean copyString(String chars) {
    if (clipboard == null)
      makeClipboardObject();
    if (clipboard != null) {
      Transferable fieldContent = new HtmlSelection(chars);
      clipboard.setContents (fieldContent, this);
      return true;
    }
    return false;
  }
  public void lostOwnership(Clipboard clipboard, Transferable contents) {
  }
  private static class HtmlSelection implements Transferable {
    private static ArrayList htmlFlavors = new ArrayList();
    static {
      try {
        htmlFlavors.add(new DataFlavor("text/html;class=java.lang.String"));
        htmlFlavors.add(new DataFlavor("text/html;class=java.io.Reader"));
        htmlFlavors.add(new DataFlavor("text/html;charset=unicode;class=java.io.InputStream"));
      } 
      catch (ClassNotFoundException ex) {
        ex.printStackTrace();
      }
    }
    private String html;
    public HtmlSelection(String html) {
      this.html = html;
    }
    public DataFlavor[] getTransferDataFlavors() {
      return (DataFlavor[]) htmlFlavors.toArray(new DataFlavor[htmlFlavors.size()]);
    }
    public boolean isDataFlavorSupported(DataFlavor flavor) {
      return htmlFlavors.contains(flavor);
    }
    public Object getTransferData(DataFlavor flavor) throws UnsupportedFlavorException {
      if (String.class.equals(flavor.getRepresentationClass())) {
        return html;
      } else if (Reader.class.equals(flavor.getRepresentationClass())) {
        return new StringReader(html);
      } else if (InputStream.class.equals(flavor.getRepresentationClass())) {
        return new StringBufferInputStream(html);
      }
      throw new UnsupportedFlavorException(flavor);
    }
  }
}