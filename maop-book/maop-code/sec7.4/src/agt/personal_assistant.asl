+open_voting(ArtName)
   <- lookupArtifact(ArtName, ArtId);
      vm::focus(ArtId).

+vm::options(Options)
   <- ?pref_temp(Pref);
      ?closest(Pref,Options,Vote);
      .print("I am voting for ",Vote);
      vm::vote(Vote).

{ include("base-pa.asl") }
