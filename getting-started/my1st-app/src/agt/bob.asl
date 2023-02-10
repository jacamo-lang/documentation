//!count. // initial goal

+greeting(M)[source(A)] <-  // plan to react to new beliefs
    .print("I received ",M," from ",A).

// plan to achieve goal count
+!count 
   <- inc;
      .wait(2000);
      !count.

// plan to react to new belief
+count(X)
   <- .print("counter = ",X).

// some usual includes for JaCaMo projects:
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }