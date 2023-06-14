{ include("base-rc.asl") }

!create_org. // Initial goal

+!create_org
   <-   createWorkspace(shouseo);
        joinWorkspace(shouseo, WspId);

        // creates the organisation entity
        makeArtifact(shouseo,
            "ora4mas.nopl.OrgBoard",
            ["src/org/smart_house.xml"],
            OrgArtId)[wid(WspId)];
        focus(OrgArtId)[wid(WspId)];
        createGroup(r1, room, GrArtId)[artifact_id(OrgArtId)];
        focus(GrArtId)[wid(WspId)];

        // adopts the role controller in the group
        adoptRole(controller)[artifact_id(GrArtId)];

        // announces to others the new group, so they can join
        .broadcast(tell,new_gr(shouseo,r1));
   .
