package devices;

import cartago.*;

public class HVAC extends Artifact {

	private TemperatureSensorPanel sensorPanel;
	private RoomControlPanel roomControlPanel;

	private double temperature;
	private double preferredTemperature;

	void init(int temp, int prefTemp){
		this.temperature = temp; // initial simulated value
		this.preferredTemperature = prefTemp;
		defineObsProperty("state","idle");
		defineObsProperty("temperature",temperature);
 		defineObsProperty("preferred_temperature",preferredTemperature);

		sensorPanel = new TemperatureSensorPanel(this,temp);
		sensorPanel.setVisible(true);

		roomControlPanel = new RoomControlPanel(this,prefTemp);
		roomControlPanel.setVisible(true);

	}

	@OPERATION void startHeating(){
		getObsProperty("state").updateValue("heating");
		this.execInternalOp("updateTemperatureProc",0.5);
	}

	@OPERATION void startCooling(){
		getObsProperty("state").updateValue("cooling");
		this.execInternalOp("updateTemperatureProc",-0.5);
	}

	@OPERATION void stopAirConditioner(){
		getObsProperty("state").updateValue("idle");
	}

	@INTERNAL_OPERATION void updateTemperatureProc(double step){
		ObsProperty prop = getObsProperty("temperature");
		while (!getObsProperty("state").stringValue().equals("idle")){
			double temp = prop.doubleValue();
			prop.updateValue(temp+step);
			sensorPanel.setTempValue((int)(Math.round(temp+step)));
			this.await_time(100);
		}
	}

	void notifyNewTemperature(double value){
		ObsProperty prop = getObsProperty("temperature");
		prop.updateValue(value);
	}

	void notifyNewPreferredTemperature(double value){
		ObsProperty prop = getObsProperty("preferred_temperature");
		prop.updateValue(value);
	}


}
