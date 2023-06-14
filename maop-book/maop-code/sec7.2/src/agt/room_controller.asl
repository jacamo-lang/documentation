// gets the average of prefered temperatures sent by user agents
average_pt(T) :- .findall(UT, pref_temp(UT), LT) &
              LT \== [] &
              T = math.average(LT).

//average_pt(22). // default average of prefered temperatures

tolerance(0.4). // used in temp_management
{ include("temp_management.asl") }

// change the target temperature whenever a new prefered temperature is received
// TODO Check that we don't need to have an atomic plan here: what happens if one agent sends a new pref_temp while this one is under consideration?
+pref_temp(UT)[source(Ag)]
   <- .println("New preference from ", Ag, " = ",UT);
      // the following test is necessary only if user agents do not send untell of previous preferences
      if (pref_temp(Y)[source(Ag)] & UT \== Y) { // a kind of belief revision
         -pref_temp(Y)[source(Ag)];              // keeps just the last preference of some agent
      }
      ?average_pt(T);
      .drop_desire(temperature(_));
      .println("Creating a new goal to set temperature to ",T);
      !temperature(T).

/*
+pref_temp(X)[source(Ag)|LA] : not .member(time(_),LA)
   <- -pref_temp(X)[source(Ag)];
      +pref_temp(X)[source(Ag),time(system.time)];
      ?average_pt(T);
      .drop_desire(temperature(_));
      !temperature(T).
*/

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$jacamoJar/templates/org-obedient.asl") }
