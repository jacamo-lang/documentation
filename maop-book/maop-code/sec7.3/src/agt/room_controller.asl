conv_id(1).

all_ballots_received(ConvId)
  :- .all_names(L) & .length(L,NP) &             // number of voters
     .count(ballot(ConvId,_)[source(_)], NP-1).    // equals number of votes

// start a voting protocol whenever a new prefered temperature is received
+pref_temp(UT)[source(Ag)]
      // the following test is necessary only if user agents do not send untell of previous preferences
   <- .println("New preference from ", Ag, " = ",UT);
      if (pref_temp(Y)[source(Ag)] & UT \== Y) { // a kind of belief revision
         -pref_temp(Y)[source(Ag)];              // keeps just the last preference of some agent
      }
      !open_voting.

+!open_voting
   <- !get_id(Id);
      .findall(T,pref_temp(T)[source(_)],Options); // TODO: implement it
      // TODO check that the received options are part of the list to prevent cheating
      .broadcast(tell, open_voting(Id, Options, 4000));
      .wait(all_ballots_received(Id), 4000, _);
      !close_voting(Id);
   .

@lId[atomic]
+!get_id(ConvId) : conv_id(ConvId)  <- -+conv_id(ConvId+1).

+!close_voting(Id)
   <- ?ballot(Id,T); // TODO: implement this as !borda_count(Id,Winner);
      //.abolish(vote(Id,_));
      .println("New goal to set temperature to ",T);
      .drop_desire(temperature(_));
      !temperature(T);
      .broadcast(tell, close_voting(Id,T));
   .

{ include("base-rc.asl") }
