package tools;
import cartago.*;
import jason.asSyntax.*;
import jason.asSyntax.parser.*;
import java.util.*;

public class Dictionary extends Artifact {

  Map<String,Object> dic = new HashMap<>();

  @OPERATION void put(String k, Object v) {
    dic.put(k,v);
  }

  @OPERATION void get(String k, OpFeedbackParam<Term> r) {
    try {
      r.set(ASSyntax.parseTerm(dic.get(k).toString()));
    } catch (ParseException e) {
      failed("object "+dic.get(k)+
                 " can not be parsed as a Jason term!");
    }
  }
}
