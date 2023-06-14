conv_id(1).

// start a voting protocol whenever a new
// preferred temperature is received
+pref_temp(UT)[source(Ag)]
   <- .println("New preference from ", Ag, " = ",UT);
      // this is only necessary if personal assistant agents do not
      // send untell of previous preferences
      if (pref_temp(Y)[source(Ag)] & UT \== Y) {
         // keeps just the last preference of some agent
         -pref_temp(Y)[source(Ag)];
      }
      !open_voting.

+!open_voting
   <- !get_id(Id);
      .concat(v,Id,ArtNameS);
      .term2string(ArtNameT,ArtNameS);
      .findall(T,pref_temp(T)[source(_)],Options);
      .all_names(AllAgents);
      .my_name(Me);
      .delete(Me,AllAgents,Voters);
      vm::makeArtifact(ArtNameS,"voting.VotingMachine",[],ArtId);
      vm::focus(ArtId);
      vm::open(Options, Voters, 4000);
      .broadcast(tell, open_voting(ArtNameT));
   .

@lId[atomic]
+!get_id(ConvId) : conv_id(ConvId)  <- -+conv_id(ConvId+1).

+vm::result(T)[artifact_name(ArtName)]
   <- .println("Creating a new goal to set temperature to ",T);
      .drop_desire(temperature(_));
      !temperature(T);
      .broadcast(untell, open_voting(ArtName));
      //disposeArtifact(ArtId);
   .

{ include("base-rc.asl") }
