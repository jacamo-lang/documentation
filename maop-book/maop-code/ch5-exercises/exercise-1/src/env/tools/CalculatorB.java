package tools;
import cartago.*;

public class CalculatorB extends Calculator {
    
    double mem = 0; 

    @OPERATION void storeResult() {
        mem = getObsProperty("lastResult").doubleValue();
    }

    @OPERATION void recall() {
        getObsProperty("lastResult").updateValue(mem);
    }
}
 
