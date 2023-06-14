package tools;
import cartago.*;
import jason.asSyntax.*;

public class Table extends Artifact {
  @OPERATION void play() {
    // getOpUserName() returns the name of the agent
    // executing this operation
    signal("played", ASSyntax.createAtom(getOpUserName()));
    // the type of the argument is Jason Atom
  }
}
