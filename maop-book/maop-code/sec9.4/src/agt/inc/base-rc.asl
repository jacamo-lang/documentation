tolerance(0.4). // used in temp_management

+!open_voting[scheme(S)]
   <- // get temperature preferentes sent by message from assistants
      .findall(T,pref_temp(T)[source(_)],Options);

      // get voters from organisation (agents playing assistant)
      .findall(A, play(A,assistant,_), Voters);

      // opens "voting machine" for votes
      vm::open(Options, Voters, 4000);
      .print("Options are ",Options," voters are ",Voters);

      // set the argument of organisational goal "vote"
      setArgumentValue(vote,voting_machine_id,v1)[artifact_name(S)];
   .

+!close_voting
   <- ?vm::result(T);
      .println("Creating a new goal to set temperature to ",T);
      .drop_desire(temperature(_));
      !!temperature(T);
   .


{ include("temp_management.asl") }

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$jacamoJar/templates/org-obedient.asl") }
