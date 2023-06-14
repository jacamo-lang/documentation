+new_gr(Workspace,GroupName)
   <-  joinWorkspace(Workspace,WspId);
       lookupArtifact(GroupName,GrArtId)[wid(WspId)];
       adoptRole(assistant)[artifact_id(GrArtId)];
       focus(GrArtId)[wid(WspId)];
   .

+activity(A) : A \== "none"
   <- .print("New user activity ",A);
      // gets some art ids
      ?focused(shouseo,r1,GrBoardId);
      ?joined(shouseo,WspId);

      // computes a new schme id
      ?schemes(L); // L is the list of group's schemes
      .concat("sch_", .length(L)+1, Name);

      // creates the new scheme
      createScheme(Name, decide_temp, SchArtId)
                    [wid(WspId),artifact_name(shouseo)];
      addScheme(Name)[artifact_id(GrBoardId)];
      focus(SchArtId)[wid(WspId)];
   .

{ include("base-pa.asl") }
