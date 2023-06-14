// when the organization gives me permission to
// commit to a mission M in scheme S,
// do that if it matches the belief my_mission
+permission(A,_,committed(A,M,S),_)
   :  .my_name(A) &  // the permission is for me
      my_mission(M)  // my mission is M
   <- commitMission(M).

// when I have goal show_w1, create subgoal say(...)
+!show_w1  <- !say("Hello").
+!show_w2  <- !say("World").

+!say(M) <- writeMsg(M).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
