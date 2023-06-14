package devices;

import java.awt.Dimension;
import javax.swing.*;


class RoomControlPanel extends JFrame {

	private JTextField tempValue;
	private JSlider temp;
	private HVAC hvac;

	public RoomControlPanel(HVAC hvac, int startTemp){
		setTitle("..:: Room Control Panel ::..");
		setSize(400,120);

		this.hvac = hvac;

		JPanel mainPanel = new JPanel();
		mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.Y_AXIS));
		setContentPane(mainPanel);

		JPanel temperature = new JPanel();
		temperature.setLayout(new BoxLayout(temperature, BoxLayout.Y_AXIS));

		JPanel temperature1 = new JPanel();
		temperature1.setLayout(new BoxLayout(temperature1, BoxLayout.X_AXIS));

		tempValue = new JTextField(5);
		tempValue.setText(""+startTemp);
		tempValue.setSize(100, 30);
		tempValue.setMinimumSize(tempValue.getSize());
		tempValue.setMaximumSize(tempValue.getSize());
		tempValue.setEditable(false);

		temperature1.add(new JLabel("Preferred Temperature:"));
		temperature1.add(Box.createRigidArea(new Dimension(0,5)));
		temperature1.add(tempValue);

		temp = new JSlider(JSlider.HORIZONTAL, 5, 45, startTemp);
		temp.setSize(300, 60);
		temp.setMinimumSize(temp.getSize());
		temp.setMaximumSize(temp.getSize());
		temp.setMajorTickSpacing(10);
		temp.setMinorTickSpacing(1);
		temp.setPaintTicks(true);
		temp.setPaintLabels(true);
		temp.addChangeListener((ev) -> {
			JSlider source = (JSlider) ev.getSource();
	        int value = (int) source.getValue();
	        tempValue.setText(""+value);
			if (!source.getValueIsAdjusting()) {
				hvac.beginExtSession();
	            hvac.notifyNewPreferredTemperature(value);
	            hvac.endExtSession();
			}
		});

		temperature.add(temperature1);
		temperature.add(temp);

		mainPanel.add(temperature);
	}
}
