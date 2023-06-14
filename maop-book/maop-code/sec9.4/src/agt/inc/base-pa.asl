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


+!create_GUI
   <- .my_name(Me);
      .concat(gui_,Me,ArtName);
      makeArtifact(ArtName, "gui.UserGUI", [], ArtId);
      focus(ArtId);
   .

+!preferences
<- ?pref_temp(T); // consults my personal preference
   .send(rc, tell, pref_temp(T)); // and send to rc
.

+!vote
<- .wait(300); // thinking on how to vote...
   // get the name of the voting machine artifact
   // defined for organisational goal "vote"
   ?goalArgument(_, vote, "voting_machine_id", VMName);
   // get the workspace id where the voting machine is
   ?joined(vmws,VWId);
   lookupArtifact(VMName,VMId)[wid(VWId)];
   // focus on the voting VotingMachine using namespace vm
   vm::focus(VMId)[wid(VWId)];

   // consult the temperature options
   ?vm::options([First,Second|_]);
   // simply vote on the second option (!)
   vm::vote([Second]);
.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
