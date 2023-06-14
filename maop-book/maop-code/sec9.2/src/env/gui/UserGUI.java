package gui;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import cartago.OPERATION;
import cartago.tools.GUIArtifact;

public class UserGUI extends GUIArtifact {

	private InputWindow frame;

	public void setup() {
		try {
			frame = new InputWindow(getCreatorId().getAgentName() );
			frame.pack();

			defineObsProperty("activity", "none");

			linkActionEventToOp(frame.updateButton,"updateActivity");
			linkActionEventToOp(frame.exitButton,"exit");
			linkKeyStrokeToOp(frame.activityField,"ENTER","updateActivity");

			frame.setVisible(true);
		} catch (Exception ex){
			ex.printStackTrace();
		}
	}

	@OPERATION void updateActivity(ActionEvent ev) {
		frame.exitButton.setEnabled(true);
		getObsProperty("activity").updateValue( frame.getActivity() );
	}

	@OPERATION void exit(ActionEvent ev) {
		frame.activityField.setText("none");
		frame.exitButton.setEnabled(false);
		getObsProperty("activity").updateValue( "none" );
	}


	private static int nbF = 1;

	class InputWindow extends JFrame {

		private JButton updateButton;
		private JButton exitButton;
		private JTextField activityField;


		public InputWindow(String user){
			setTitle("..:: User Interface for "+user+" ::..");

			nbF++;
			setLocation(30, 80*nbF);

			JPanel mainPanel = new JPanel();
			mainPanel.setLayout(new FlowLayout());
			setContentPane(mainPanel);

			JPanel currentTempPanel = new JPanel();
			currentTempPanel.setLayout(new FlowLayout());

			activityField = new JTextField(20);
			activityField.setText("none");
			activityField.setEditable(true);

			updateButton = new JButton("set");
			exitButton = new JButton("exit");
			exitButton.setEnabled(false);

			currentTempPanel.add(new JLabel("Activity: "));
			currentTempPanel.add(activityField);
			currentTempPanel.add(updateButton);
			currentTempPanel.add(exitButton);

			mainPanel.add(currentTempPanel);
		}

		public String getActivity() {
			return activityField.getText().trim();
		}
	}
}
