package tools;
import cartago.*;

public class Blackboard extends Artifact {

  void init() {
    defineObsProperty("lastMsg","");
  }
	
  @OPERATION void writeMsg(String msg) {
    System.out.println("[BLACKBOARD] " + msg);
    getObsProperty("lastMsg").updateValue(msg);
  }
}
