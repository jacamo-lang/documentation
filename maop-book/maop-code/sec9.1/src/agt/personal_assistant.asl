
+activity(A) : A \== "none"
  <- .print("New user activity ",A);
     // create a scheme to setup the new temperature
     //createScheme(st,decide_temp,AId);
     //focus(AId);
     //addScheme(st);

     resetGoal(voting);
  .

+!preferences
  <- ?pref_temp(T); // consults my personal preference
     .send(rc, tell, pref_temp(T)); // and send to rc
  .

+!ballot
  <- .wait(300); // thinking on how to vote...
     // get the name of the voting machine artifact
     // defined for organizational goal "vote"
     ?goalArgument(_, ballot, "voting_machine_id", VMName);
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

{ include("$moiseJar/asl/org-obedient.asl") }

// commit to missions when permitted
+permission(Ag,Norm,committed(Ag,Mission,Scheme),Deadline)[artifact_id(ArtId),workspace(_,W)]
    : .my_name(Ag)
   <- //.print("I am permitted to commit to ",Mission," on ",Scheme,"... doing so");
      commitMission(Mission)[artifact_name(Scheme), wid(W)].

{ include("base-pa.asl") }
