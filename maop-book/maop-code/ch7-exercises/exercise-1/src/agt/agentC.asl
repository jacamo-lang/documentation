c(0). // counter as belief
+played(_) : c(X) <- -+c(X+1); .print("ping ",X).
{ include("$jacamoJar/templates/common-cartago.asl") }
