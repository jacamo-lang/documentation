// Agent sample_agent in project bookmaop_org

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true
   <- .print("hello world.");
      createWorkspace("singlememberorg");
      joinWorkspace("singlememberorg",WOrg);
      makeArtifact(myorg, "ora4mas.nopl.OrgBoard", ["src/org/org.xml"], OrgArtId)[wid(WOrg)];
      focus(OrgArtId);
      createGroup(g1, group1, GrArtId)[artifact_id(OrgArtId)];
//      debug(inspector_gui(on))[artifact_id(GrArtId)];
adoptRole(role1)[artifact_id(GrArtId)];
adoptRole(role2)[artifact_id(GrArtId)];
      focus(GrArtId);
      // Second organisation entity
      createWorkspace("sharedorg");
      joinWorkspace("sharedorg",WOrgBis);
      makeArtifact(sharedorg, "ora4mas.nopl.OrgBoard", ["src/org/org.xml"], OrgArtIdBis)[wid(WOrgBis)];
      focus(OrgArtIdBis);
      createGroup(g1, group1, GrArtIdBis)[artifact_id(OrgArtIdBis)];
      adoptRole(role1)[artifact_id(GrArtIdBis)];
      focus(GrArtIdBis);
.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
