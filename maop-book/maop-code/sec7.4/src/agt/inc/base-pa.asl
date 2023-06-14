closest(X,[H|T],H) :- X > H.
closest(X,[H1,H2|T],H1)
   :- X < H1 & X > H2 & H1-X <= X-H2.
closest(X,[H1,H2|T],H2)
   :- X < H1 & X > H2 & H1-X > X-H2.
closest(X,[H],H).
closest(X,[H|T],V)
   :- closest(X,T,V).

// Translation of the low, medium, high temperature levels into the internal agent scale
level_temp(low,    10).
level_temp(medium, 20).
level_temp(high,   30).


// Inference of the preferred temperature level from the activity
pref_temp(T)  :- activity(A) & preferred(A,L) & level_temp(L,T).
pref_temp(20). // temperature for none activity

!create_GUI.

//!send_my_pref.
/*+!send_my_pref
   <- .wait(100+math.random(500)); // some time to decide :-)
      .send(rc,tell,pref_temp(math.random(30)+10)).
*/

+!create_GUI
   <- .my_name(Me);
      .concat(gui_,Me,ArtName);
      makeArtifact(ArtName, "gui.UserGUI", [], ArtId);
      focus(ArtId);
   .

+activity(A) : A \== "none"
  <- ?pref_temp(T);
     .print("New user activity ",A," preferred temperature is ",T);
     .send(rc,tell,pref_temp(T));
  .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$jacamoJar/templates/org-obedient.asl") }
