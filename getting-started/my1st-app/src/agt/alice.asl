// initial goals
!say_hello.     
!count.

// plan to achieve goal say_hello
+!say_hello
   <- .wait(play(Ag,role2,_)); // consult the agent playing role2, var Ag is bound to the name of agent playing role2
      .send(Ag,tell,greeting("hello world")).

// plan to achieve goal count
+!count 
   <- inc_get(1,NewValue);
      .print("I've got the unique value of ",NewValue);
      .wait(1000);
      !count.

// some usual includes for JaCaMo projects:
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
