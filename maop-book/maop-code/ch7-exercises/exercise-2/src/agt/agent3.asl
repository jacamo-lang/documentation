!play.                                  // new inicial goal
+!start <- play.                            // initial play

+!play
  <-                                     // wait other play
     .wait( last_played(A) & not .my_name(A));
     .wait(1000);
     play;                                        // action
     !play.               // continue with the goal to play
+stop <- .drop_intention(play).      // drop goal contition

+played(A) // store the signal as a belief (used in line 6)
  <- .print("Agent ",A," has played");
     -+last_played(A).

{ include("$jacamoJar/templates/common-cartago.asl") }
