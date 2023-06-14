closest(X,[H|T],H) :- X > H.
closest(X,[H1,H2|T],H1)
   :- X < H1 & X > H2 & H1-X <= X-H2.
closest(X,[H1,H2|T],H2)
   :- X < H1 & X > H2 & H1-X > X-H2.
closest(X,[H],H).
closest(X,[H|T],V)
   :- closest(X,T,V).

+open_voting(ConvId, Options, TimeOut)[source(Sender)]
   <- ?pref_temp(Pref);
      ?closest(Pref,Options,Vote); // the individual strategy
      .print("My vote is ",Vote);
      .send(Sender, tell, ballot(ConvId, Vote)).

{ include("base-pa.asl") }
