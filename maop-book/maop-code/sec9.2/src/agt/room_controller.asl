+!open_voting[scheme(S)]
   <- // get temperature preferentes sent by message from assistants
      .findall(T,pref_temp(T)[source(_)],Options);

      // get voters from organization (agents playing assistant)
      .findall(A, play(A,assistant,_), Voters);

      // open "voting machine" for votes
      vm::open(Options, Voters, 4000);
      .print("Options are ",Options," voters are ",Voters);

      // set the argument of organizational goal "vote"
      setArgumentValue(ballot,voting_machine_id,v1)[artifact_name(S)];
   .

+!close_voting
   <- ?vm::result(T);
      .println("Creating a new goal to set temperature to ",T);
      .drop_desire(temperature(_));
      !!temperature(T);
   .

{ include("base-rc.asl") }

+!set_average
   <- .findall(T,pref_temp(T)[source(_)],Options);
      AT = math.average(Options);
      .println("(average case) Creating a new goal to set temperature to  ",AT);
      .drop_desire(temperature(_));
      !!temperature(AT);
   .
