/*
 * ROOM AGENT 
 *
 * achieve a target temperature, specified in the goal.
 */ 
tolerance(0.4).

temperature_in_range(T)
	:- not now_is_colder_than(T) & not now_is_warmer_than(T).

now_is_colder_than(T)
	:- temperature(C) & tolerance(DT) & (T - C) > DT.

now_is_warmer_than(T)
	:- temperature(C) & tolerance(DT) & (C - T) > DT.
	
@p1[atomic]
+temperature(C): preferred_temperature(T) & not temperature_in_range(T) & not .desire(temperature(_))
	<- 
		println("Reacting to temperature change");
		!temperature(T).

@p2[atomic]
+preferred_temperature(T): not temperature_in_range(T) & not .desire(temperature(_))
	<- 
		println("Reacting to temperature preference change");
		!temperature(T).

@p3[atomic]
+preferred_temperature(T): not temperature_in_range(T) & .desire(temperature(T1)) & T1 \== T
	<- 
		println("Reacting to temperature preference change");
		.drop_desire(temperature(T1));
		stopAirConditioner;
		!temperature(T).
				
// ---
					
+temperature(T)
	<- println("temp perceived: ",T).
						
+!temperature(T): temperature_in_range(T)
	<- 	println("Temperature achieved: ",T).
		
+!temperature(T): now_is_colder_than(T)
	<-  println("It is too cold -> heating...");
	    startHeating;
		!heat_until(T).

+!temperature(T): now_is_warmer_than(T) 
	<-  println("It is too hot -> cooling...");
	    startCooling;
		!cool_until(T).

// --

+!heat_until(T): temperature_in_range(T)
 	<-  stopAirConditioner;
 		println("Temperature achieved ",T).

+!heat_until(T): now_is_colder_than(T)
	<-  .wait(100);
	    !heat_until(T).

+!heat_until(T): now_is_warmer_than(T)
	<-  stopAirConditioner;
	    !temperature(T).
		
+!cool_until(T): temperature_in_range(T)
 	<- stopAirConditioner;
 	   println("Temperature achieved ",T).

+!cool_until(T): now_is_warmer_than(T) 
	<-  .wait(100);
	    !cool_until(T).

+!cool_until(T): now_is_colder_than(T) 
	<-  stopAirConditioner;
	    !temperature(T).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
		
		

