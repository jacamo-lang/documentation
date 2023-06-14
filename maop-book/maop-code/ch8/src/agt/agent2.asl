// Agent sample_agent in project bookmaop_org

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true
<-
   joinWorkspace(sharedorg,WspId);
   lookupArtifact(sg1,GrArtId)[wid(WspId)];
   adoptRole(role1)[artifact_id(GrArtId)];
   adoptRole(role2)[artifact_id(GrArtId)];
   focus(GrArtId)[wid(WspId)];
.

+!goal2[scheme(sch1),source(self)] <- .println("satisfying goal2 in sch1"); +goal2.
+!goal3[scheme(sch1),source(self)] <- .println("satisfying goal3 in sch1"); +goal3.
+!goal4[scheme(sch1),source(self)] <- .println("satisfying goal4 in sch1"); +goal4.
+!goal2[scheme(ssch1),source(self)] <- .println("satisfying goal2 in ssch1"); +goal2.
+!goal3[scheme(ssch1),source(self)] <- .println("satisfying goal3 in ssch1"); +goal3.
+!goal4[scheme(ssch1),source(self)] <- .println("satisfying goal4 in ssch1"); +goal4.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }
