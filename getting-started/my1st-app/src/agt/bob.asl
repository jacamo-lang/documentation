!count. // initial goal

// plan to react to new beliefs
+greeting(M)[source(A)]
   <- .print("I received ",M," from ",A).

// plan to achieve goal count
+!count 
   <- inc;          // act on the  environment
      .wait(2000);  // wait a bit and
      !count.       // keep counting

// plan to react to new changes in count belief
+count(X)
   <- .print("counter = ",X).

// some usual includes for JaCaMo projects:
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }