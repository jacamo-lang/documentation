// initial goals
!say_hello.     
!count.

// plan to achieve goal say_hello
+!say_hello
   <- .wait(play(Ag,role2,_)); // waits for a belief play/3 with the second term equals role2. 
                               // Ag is bound to the name of the agent playing role2
      .send(Ag,tell,greeting("hello world")).

// plan to achieve goal count
+!count 
   <- inc_get(1,NewValue);
      .print("I've got the unique value of ",NewValue);
      .wait(1000);
      !count.

// some usual includes for JaCaMo projects:
{ include("$jacamo/templates/common-cartago.asl") }
{ include("$jacamo/templates/common-moise.asl") }
{ include("$moise/asl/org-obedient.asl") }
