!test. // inicial goal

+!test
  <- sum(10.1,S); sum(S,R);
     storeResult;
     sum(1000,_);
     recall.

+lastResult(S) <- .print("Sum is now ",S).

{ include("$jacamoJar/templates/common-cartago.asl") }
