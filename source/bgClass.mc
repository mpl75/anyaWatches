using Toybox.Application.Storage;

(:background)
class BackgroundServiceDelegate extends Toybox.System.ServiceDelegate {
  function initialize() {
    System.ServiceDelegate.initialize();
  }

  function onTemporalEvent() {
    var deg = Storage.getValue("posDeg");
    
    var systemSettings = System.getDeviceSettings();
    var uniq = systemSettings.uniqueIdentifier;    
    
    var myTheme = Application.Properties.getValue("myTheme");    

    Communications.makeWebRequest(
      "https://portal.triobo.com/_develop/garminAPI.php",
      {
        "lat" => deg[0].toString(),
        "lon" => deg[1].toString(),
        "ver" => "3",
        "uniq" => uniq,
        "theme" => myTheme
      },
      {
	   :method => Communications.HTTP_REQUEST_METHOD_GET,      // set HTTP method
	   :headers => {                                           // set headers
	           "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED},
	                                                           // set response type
	   :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
      },
      method(:responseCallback)
    );
  }

  function responseCallback(responseCode, data) {
    var res = 0;
    if (responseCode == 200){
      res = data;
    } else {
      res = responseCode;
    }
    Background.exit(res);
  }
}

