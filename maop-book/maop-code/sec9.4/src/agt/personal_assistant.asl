{ include("$moiseJar/asl/org-rules.asl") }

role_goal(R,G) :-
   role_mission(R,_,M) &
   mission_goal(M,G).

has_plans_for(G) :-
   .relevant_plans({+!G},LP) & LP \== [].

i_have_plans_for(R) :-
   not (role_goal(R,G) & not has_plans_for(G)).

has_enough_players_for(R) :-
   role_cardinality(R,Min,Max) &
   .count(play(_,R,_),NP) &
   NP >= Min.

+new_gr(OrgName,GroupName)
   <-  // waits some time,
       // so that assistants do not run this plan togheter
       .wait( math.random(2000) );

       // focus on the OrgBoard to get its specification
       joinWorkspace(OrgName,WspId);
       lookupArtifact(OrgName,OrgArtId)[wid(WspId)];
       focus(OrgArtId)[wid(WspId)];

       // focus on the GrBoard to get players
       lookupArtifact(GroupName,GrArtId)[wid(WspId)];
       focus(GrArtId)[wid(WspId)];

       if (i_have_plans_for(assistant)) {
         if (not has_enough_players_for(assistant)) {
           adoptRole(assistant)[artifact_id(GrArtId)];
         } else {
           .print("There are enough assistants already!");
         }
       } else {
         .print("I do not have plans for role assistant!");
         .findall(G,
              role_goal(assistant,G) & not has_plans_for(G),
              LG);
         .print("No plans for ", LG);
       }
   .

{ include("pa.asl") }
