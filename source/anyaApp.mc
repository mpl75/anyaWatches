using Toybox.Application as App;
using Toybox.WatchUi as Ui;

var myView;
var bgHasRun = 0;

class anyaApp extends App.AppBase {

    function initialize() {
      AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        myView = new anyaView();
        return [myView];
    }

	function onSettingsChanged() { // triggered by settings change in GCM
	    myView.initColors();
	    WatchUi.requestUpdate(); 
	}

    function getServiceDelegate(){
      return [new BackgroundServiceDelegate()];
    }
    
    function onBackgroundData(data){
      if (bgHasRun == 0) {
        Background.registerForTemporalEvent(new Time.Duration(120 * 60));
        System.println("Zahájeno spouštění každých 120 minut");
        bgHasRun = 1;
      }    
      if (data instanceof Toybox.Lang.Number) {
        System.println("Error receiving weather" );
      } else {
	    Storage.setValue("posDeg", [data["lat"].toFloat(), data["lon"].toFloat()]);
	    Storage.setValue("Weather0t", data["weather"][0]["t"]);
	    Storage.setValue("Weather0i", data["weather"][0]["i"]);
	    Storage.setValue("Weather1t", data["weather"][1]["t"]);
	    Storage.setValue("Weather1i", data["weather"][1]["i"]);
	    Storage.setValue("Weather2t", data["weather"][2]["t"]);
	    Storage.setValue("Weather2i", data["weather"][2]["i"]);
	    Storage.setValue("Weather3t", data["weather"][3]["t"]);
	    Storage.setValue("Weather3i", data["weather"][3]["i"]);
	  }
    }
}
