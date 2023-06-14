+!start <- play.
+played(A)
  :  not .my_name(A) // it is my turn
  <- .print("Agent ",A," has played");
     .wait(1000);
     play.
{ include("$jacamoJar/templates/common-cartago.asl") }
