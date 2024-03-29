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
	

+temperature(T) <- println("Temperature perceived: ",T).
				
+!temperature(T): temperature_in_range(T)
	<- 	println("Temperature achieved: ",T).
		
+!temperature(T): now_is_colder_than(T)
	<-  println("It is too cold -> heating...");
	    startHeating;
		!heat_until(T).

+!heat_until(T): temperature_in_range(T)
 	<-  stopAirConditioner;
 		println("Temperature achieved ",T).

+!heat_until(T): now_is_colder_than(T)
	<-  .wait(100);
	    !heat_until(T).

+!heat_until(T): now_is_warmer_than(T)
	<-  stopAirConditioner;
	    !temperature(T).

+!temperature(T): now_is_warmer_than(T) 
	<-  println("It is too hot -> cooling...");
	    startCooling;
		!cool_until(T).
		
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
		
		

