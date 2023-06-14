!test. // inicial goal

+!test <- put(k1,10); put("k5",test(100));
          get(k1,V1); .print(V1);
          get(k5,V2); .print(V2).

{ include("$jacamoJar/templates/common-cartago.asl") }
