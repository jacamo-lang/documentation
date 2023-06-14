package tools;
import cartago.*;

public class Calculator extends Artifact {

  void init() {
    defineObsProperty("lastResult",0.0);
  }

  @OPERATION void sum(double a, OpFeedbackParam<Double> result){
    ObsProperty p = getObsProperty("lastResult");
    double res = a + p.doubleValue();
    p.updateValue(res);
    result.set(res);
  }
}
