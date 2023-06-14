new_cake("Biscuit Cake"). // to simulate new cake advert
have(money).    // I initially believe I have some money

+new_cake(X) <- !have(cake(X)).     // reactive behavior

                                  // proactive behavior:
 // two possible plans to acheive the goal have(cake(_))
+!have(cake(X)) : have(money) <- !buy(X).
+!have(cake(X)) : have(flour) & have(salt) & have(sugar) &
                  have(vanilla) & have(oven)
  <- !make(X).

+!buy(X)  <- .print("Buying ",X).
+!make(X) <- .print("Making ",X).
