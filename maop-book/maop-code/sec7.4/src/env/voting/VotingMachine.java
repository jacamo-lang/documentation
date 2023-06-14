package voting;

import java.util.*;

import cartago.OPERATION;
import cartago.tools.GUIArtifact;
import jason.asSyntax.*;
import jason.asSyntax.parser.*;

public class VotingMachine extends GUIArtifact {

    List<String> voters;
    List<Object> votes;
    int timeout;

    public void init() {
        defineObsProperty("status", "closed");
    }

    @OPERATION
    public void open(Object[] options, Object[] voters, int timeout) {
        this.voters  = new ArrayList<>();
        this.votes   = new ArrayList<>();

        ListTerm os = ASSyntax.createList();
        for (Object o: options)
            try {
                os.add(ASSyntax.parseTerm(o.toString()));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        for (Object o: voters)
            this.voters.add(o.toString());
        this.timeout = timeout;

        defineObsProperty("options", os);
        defineObsProperty("deadline", this.timeout);
        getObsProperty("status").updateValue("open");
    }

    @OPERATION
    void vote(Object vote) {
        if (getObsProperty("status").getValue().equals("close")) {
            failed("the voting machine is closed!");
        }
        if (voters.remove(getCurrentOpAgentId().getAgentName())) {
            votes.add(vote);
            if (voters.isEmpty()) {
                close();
            }
        } else {
            failed("you voted already!");
        }
    }

    void close() {
        defineObsProperty("result", computeResult());
        getObsProperty("status").updateValue("closed");
    }

    int computeResult() {
        return 10; // TODO: implement it
    }
}

// TODO: implement timeout down-counter
