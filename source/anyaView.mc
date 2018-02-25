using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor;
using Toybox.Activity;
using Toybox.Math;
using Toybox.Position;

using Toybox.Application.Storage;

class anyaView extends Ui.WatchFace {	

  var hrString = "--";
  var distanceUnits = 0;
  var hour = 23;
  var min = 45;
  var bgRunning = 0;
  var systemSettings;
  
  var colors;
  var params;
  
  function initialize() {   
    WatchFace.initialize();
  }

  var sc = new SunCalc();  

  // Load your resources here
  function onLayout(dc) {
    setLayout(Rez.Layouts.WatchFace(dc));

    systemSettings = Sys.getDeviceSettings();
    var myResolution = systemSettings.screenWidth + "x" + systemSettings.screenHeight;
    Sys.println("Resolution " + myResolution);
    switch (myResolution) {
      case "218x218":
        params = {
          :calPosX => 23,
          :calPosY => 59,
          :calStepX => 25,
          :calWidth => 23,
          :calHeight => 20,
          :hrSteps => 21,
          :hrPosX => 91,
          :hrPosY => 168,
          :batPosX => 99,
          :batPosY => 8
        };
        break;
      default:
        params = {
          :calPosX => 18,
          :calPosY => 65,
          :calStepX => 30,
          :calWidth => 25,
          :calHeight => 24,
          :hrSteps => 25,
          :hrPosX => 96,
          :hrPosY => 188,
          :batPosX => 110,
          :batPosY => 10
        };
        break;
    }
    initColors(); 
}

  function initColors() {
//    var myTheme = 7;
    var myTheme = Application.Properties.getValue("myTheme");

    switch (myTheme) {
      case 0:
        colors = {
          :bgMain => 0x000000,
          :bgTop => 0x000055,
          :bgBottom => 0x000055,
          :bgLines => 0x0000AA,
          :time => 0xFFFFFF,
          :HRcolorBar => 0xAA0000,
          :HRcolorLine => 0xFF5555,
          :HRgraph => 0x555555,
          :icons => 0xFFFFFF,
          :middleValues => 0xAAAAAA,
          :middleLegend => 0xFFFFFF,
          :suns => 0xFFAA00,
          :bottomValues => 0xFFFFFF,
          :bottomLegend => 0xAAAAAA,
          :calendar => 0xAAAAAA,
          :calendarSunday => 0xAA0000,
          :weatherValues => 0xAAAAAA,
          :weatherIcons => 0xFFFFFF,
          :batteryBar => 0x00FF00,
          :batteryWarn => 0xFF0000
        };
        break;
      case 1:
        colors = {
          :bgMain => 0xAA00FF,
          :bgTop => 0xFF00FF,
          :bgBottom => 0xFF00FF,
          :bgLines => 0xAA00AA,
          :time => 0xFFFFFF,
          :HRcolorBar => 0xFFAAAA,
          :HRcolorLine => 0xAA00FF,
          :HRgraph => 0xAA00AA,
          :icons => 0xFFFFFF,
          :middleValues => 0xFFFFFF,
          :middleLegend => 0xFFFFFF,
          :suns => 0xFFAA00,
          :bottomValues => 0xFFFFFF,
          :bottomLegend => 0xFFFFFF,
          :calendar => 0xFFFFFF,
          :calendarSunday => 0xFF00FF,
          :weatherValues => 0xFFFFFF,
          :weatherIcons => 0xFFFFFF,
          :batteryBar => 0xFFFFFF,
          :batteryWarn => 0xFF0000
        };
        break;
      case 2:
        colors = {
          :bgMain => 0xFFFFFF,
          :bgTop => 0xAAFFFF,
          :bgBottom => 0xAAFFFF,
          :bgLines => 0x5555AA,
          :time => 0x000000,
          :HRcolorBar => 0xFF0000,
          :HRcolorLine => 0xFF5555,
          :HRgraph => 0xAAAAAA,
          :icons => 0x0000AA,
          :middleValues => 0x000000,
          :middleLegend => 0x0000AA,
          :suns => 0xFF5500,
          :bottomValues => 0x000000,
          :bottomLegend => 0x0000AA,
          :calendar => 0x000000,
          :calendarSunday => 0xAA0000,
          :weatherValues => 0x5555FF,
          :weatherIcons => 0x0000AA,
          :batteryBar => 0x00FF00,
          :batteryWarn => 0xFF0000          
        };
        break;  
      case 3:
        colors = {
          :bgMain => 0xFFFFFF,
          :bgTop => 0x55FF55,
          :bgBottom => 0x55FF55,
          :bgLines => 0x55AA55,
          :time => 0x000000,
          :HRcolorBar => 0xFF0000,
          :HRcolorLine => 0xFF5555,
          :HRgraph => 0xAAAAAA,
          :icons => 0x005500,
          :middleValues => 0x000000,
          :middleLegend => 0xAAAAAA,
          :suns => 0xFF5500,
          :bottomValues => 0x000000,
          :bottomLegend => 0x005500,
          :calendar => 0x000000,
          :calendarSunday => 0xAA0000,
          :weatherValues => 0x000000,
          :weatherIcons => 0x005500,
          :batteryBar => 0x00FF00,
          :batteryWarn => 0xFF0000          
        };
        break;
      case 4:
        colors = {
          :bgMain => 0x000000,
          :bgTop => 0x550000,
          :bgBottom => 0x550000,
          :bgLines => 0xAA0000,
          :time => 0xFFFFFF,
          :HRcolorBar => 0xAA0000,
          :HRcolorLine => 0xFF5555,
          :HRgraph => 0x555555,
          :icons => 0xFFFFFF,
          :middleValues => 0xAAAAAA,
          :middleLegend => 0xFFFFFF,
          :suns => 0xFFAA00,
          :bottomValues => 0xFFFFFF,
          :bottomLegend => 0xAAAAAA,
          :calendar => 0xAAAAAA,
          :calendarSunday => 0xAA0000,
          :weatherValues => 0xAAAAAA,
          :weatherIcons => 0xFFFFFF,
          :batteryBar => 0x00FF00,
          :batteryWarn => 0xFF0000
        };
        break;
      case 5:
        colors = {
          :bgMain => 0x000000,
          :bgTop => 0x005500,
          :bgBottom => 0x005500,
          :bgLines => 0x00AA00,
          :time => 0xFFFFFF,
          :HRcolorBar => 0xAA0000,
          :HRcolorLine => 0xFF5555,
          :HRgraph => 0x555555,
          :icons => 0xFFFFFF,
          :middleValues => 0xAAAAAA,
          :middleLegend => 0xFFFFFF,
          :suns => 0xFFAA00,
          :bottomValues => 0xFFFFFF,
          :bottomLegend => 0xAAAAAA,
          :calendar => 0xAAAAAA,
          :calendarSunday => 0xAA0000,
          :weatherValues => 0xAAAAAA,
          :weatherIcons => 0xFFFFFF,
          :batteryBar => 0x00FF00,
          :batteryWarn => 0xFF0000
        };
        break;
      case 6:
        colors = {
          :bgMain => 0xFFFFFF,
          :bgTop => 0xFFAAFF,
          :bgBottom => 0xFFAAFF,
          :bgLines => 0xFF00FF,
          :time => 0x000000,
          :HRcolorBar => 0xFF0000,
          :HRcolorLine => 0xFF5555,
          :HRgraph => 0xAAAAAA,
          :icons => 0xFF00FF,
          :middleValues => 0x000000,
          :middleLegend => 0xAAAAAA,
          :suns => 0xFF5500,
          :bottomValues => 0x000000,
          :bottomLegend => 0xFF00FF,
          :calendar => 0x000000,
          :calendarSunday => 0xAA0000,
          :weatherValues => 0x000000,
          :weatherIcons => 0xFF00FF,
          :batteryBar => 0xFF00FF,
          :batteryWarn => 0xFF0000          
        };
        break;
      case 7:
        colors = {
          :bgMain => 0xFFFFAA,
          :bgTop => 0xFF5500,
          :bgBottom => 0xFF5500,
          :bgLines => 0xFFFFFF,
          :time => 0x000000,
          :HRcolorBar => 0xAA0000,
          :HRcolorLine => 0xFF5555,
          :HRgraph => 0xAAAAAA,
          :icons => 0xFFFFFF,
          :middleValues => 0x000000,
          :middleLegend => 0x000000,
          :suns => 0xFF5500,
          :bottomValues => 0xFFFFFF,
          :bottomLegend => 0xFFFFFF,
          :calendar => 0x000000,
          :calendarSunday => 0xAA0000,
          :weatherValues => 0xFFFFFF,
          :weatherIcons => 0xFFFFFF,
          :batteryBar => 0x00FF00,
          :batteryWarn => 0xFF0000
        };
        break;
    }
  }  

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() {
  }

  function setTextAndColor (id, text, color) {
    var view = View.findDrawableById(id);
    view.setText(text);
    view.setColor(color);
  }

  // Update the view
  function onUpdate(dc) {
  
    View.findDrawableById("bgTop").setColor(colors[:bgTop], colors[:bgLines]);
    View.findDrawableById("bgMain").setColor(colors[:bgMain], colors[:bgLines]);
    View.findDrawableById("bgBottom").setColor(colors[:bgBottom], colors[:bgLines]); 

    // system status
    systemSettings = Sys.getDeviceSettings();
    setTextAndColor("Connection", systemSettings.phoneConnected ? "L" : " ", colors[:icons]);
    setTextAndColor("Notifications", systemSettings.notificationCount > 0 ? "M" : " ", colors[:icons]);
    setTextAndColor("Alarms", systemSettings.alarmCount > 0 ? "N" : " ", colors[:icons]);


	// Get and show the current time
	var clockTime = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
	hour = clockTime.hour;
	min = clockTime.min;
		
/* 	min++;
	if (min > 59) {
      min = 0;
      hour++;
    }
    if (hour > 23) {
      hour = 0;
    }*/
	
	var element;
	
	var timeArr = formatTime(hour, min, true);
    setTextAndColor("TimeLabel", timeArr[0], colors[:time]);
    setTextAndColor("AMPM", timeArr[1], colors[:time]);
				
    setTextAndColor("HeartRate", hrString, colors[:bottomValues]);

    var activity = Activity.getActivityInfo();
    
    var altString = "-";
    if (activity.altitude != null) {
      if (systemSettings.temperatureUnits == Sys.UNIT_STATUTE) {
        var altValueInKFeets = activity.altitude / 0.3048 / 1000;
        altString = altValueInKFeets.format("%.1f") + "k ft";
      } else {
        altString = activity.altitude.format("%.0f") + " m";
      }
    }
    setTextAndColor("Altitude", altString, colors[:middleValues]);

    // weather    
    var x;
    var tempUnits = systemSettings.temperatureUnits;
    distanceUnits = systemSettings.distanceUnits;
    for (var i = 0; i < 4; i++) {
      x = Storage.getValue("Weather" + i + "t");
      if (x != null) {
        if (tempUnits == Sys.UNIT_STATUTE) {
          x = x.toFloat() * 9 / 5 + 32;
          x = x.toNumber().toString() + " ºF";
	    } else {
	      x = x.toNumber().toString() + " ºC";
	    }
	    setTextAndColor("Weather" + i + "t", x, colors[:weatherValues]);
      }
      x = Storage.getValue("Weather" + i + "i");
      if (x != null) {
        setTextAndColor("Weather" + i + "i", x, colors[:weatherIcons]);
      }
    }

    var sunriseString = "-:--";
    var sunsetString = "-:--";
    var now = Time.now();
    var loc = activity.currentLocation;
    var rads = null;
    var degs = null;
    var storedRads = Storage.getValue("posRad");
    var storedDegs = Storage.getValue("posDeg");
    if (loc != null) {
      degs = loc.toDegrees();
      rads = degreesToRadians(degs);
      Sys.println("Pozice z poslední aktivity: DEG " + degs[0] + ", " + degs[1]);
      Sys.println("... přepočet na RAD " + rads[0] + ", " + rads[1]);
      Storage.setValue("posRad", rads);
      Storage.setValue("posDeg", degs);
    } else if (storedRads != null) {
      rads = storedRads;
      degs = storedDegs; 
      Sys.println("Pozice z uložené aktivity: " + degs[0] + ", " + degs[1]);
    } else if (storedDegs != null) {
      if (storedDegs[0] == 999) {
        Sys.println("Čeká se na pozici z IP");
      } else {
        degs = storedDegs;
        rads = degreesToRadians(degs);
	    Sys.println("Pozice získaná z IP: DEG " + degs[0] + ", " + degs[1]);
	    Sys.println("... přepočet na RAD " + rads[0] + ", " + rads[1]); 
	  }
    } else if (bgRunning == 0) {
      Sys.println("Bude se získávat pozice z IP");
      degs = [999, 999];
      Storage.setValue("posDeg", degs);
    }
    if (bgRunning == 0) {
	  bgRunning = 1;
	  Background.registerForTemporalEvent(new Time.Duration(5 * 60));
      Sys.println("Zahájeno spouštění každých 5 minut");
    }
        
    if (rads != null) {
	  var sunrise_moment = sc.calculate(now, rads, SUNRISE);
	  var sunset_moment  = sc.calculate(now, rads, SUNSET);
	  var sunrise = Gregorian.info(sunrise_moment, Time.FORMAT_SHORT);
      var sunset = Gregorian.info(sunset_moment, Time.FORMAT_SHORT);
      sunriseString = formatTime(sunrise.hour, sunrise.min, false);
      sunsetString = formatTime(sunset.hour, sunset.min, false);
	}
    setTextAndColor("SunRise", sunriseString, colors[:middleValues]);
    setTextAndColor("SunSet", sunsetString, colors[:middleValues]);


    var activityMonitor = ActivityMonitor.getInfo();
    setTextAndColor("Distance", centimetersToMetersOrKm(activityMonitor.distance), colors[:bottomValues]);
    setTextAndColor("Steps", "" + activityMonitor.steps, colors[:bottomValues]);
    setTextAndColor("Floors", "" + activityMonitor.floorsClimbed, colors[:bottomValues]);
    setTextAndColor("Calories", "" + activityMonitor.calories, colors[:bottomValues]);
    
    //show week
    var dayOfWeek = clockTime.day_of_week;
    //first day of week is monday
    if (dayOfWeek == 1) {
      dayOfWeek = 6;
    } else {
      dayOfWeek -= 2;
    }
    var substractDays = new Time.Duration(-Gregorian.SECONDS_PER_DAY * dayOfWeek);
    var currentDay = now.add(substractDays);
    
    for (var i=0; i<7; i++) {
      var date = Gregorian.info(currentDay, Time.FORMAT_SHORT);
      setTextAndColor("DateLabel" + i, "" + date.day, i == 6 ? colors[:calendarSunday] : colors[:calendar]);
      currentDay = currentDay.add(new Time.Duration(Gregorian.SECONDS_PER_DAY));
    }
    
    View.findDrawableById("Battery").setColor(colors[:icons]);
    View.findDrawableById("DistanceLeg").setColor(colors[:bottomLegend]);
    View.findDrawableById("StepsLeg").setColor(colors[:bottomLegend]);
    View.findDrawableById("FloorsLeg").setColor(colors[:bottomLegend]);
    View.findDrawableById("CaloriesLeg").setColor(colors[:bottomLegend]);
    View.findDrawableById("HRLeg").setColor(colors[:bottomLegend]);
    View.findDrawableById("HRG").setColor(colors[:HRgraph]);

    View.findDrawableById("SunRiseLeg").setColor(colors[:suns]);
    View.findDrawableById("SunSetLeg").setColor(colors[:suns]);
    View.findDrawableById("AltitudeLeg").setColor(colors[:middleLegend]);
    
    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);
    
    
    // mark current day of week
    dc.setColor(dayOfWeek == 6 ? colors[:calendarSunday] : colors[:calendar], -1);
    dc.setPenWidth(2);
    dc.drawRoundedRectangle(params[:calPosX] + (dayOfWeek * params[:calStepX]), params[:calPosY], params[:calWidth], params[:calHeight], 3);

    // battery level
    var systemStats = Sys.getSystemStats();
    var battery = systemStats.battery / 100 * 19;
    dc.setColor(systemStats.battery < 10 ? colors[:batteryWarn] : colors[:batteryBar], -1);
    dc.fillRectangle(params[:batPosX], params[:batPosY], 1 + battery.toNumber(), 7);
    


    //heart rate graph
    var hrIterator = ActivityMonitor.getHeartRateHistory(params[:hrSteps], false);
    var minHR = hrIterator.getMin();
    if (minHR > 60) {
      minHR = 60;
    }
    var maxHR = hrIterator.getMax();
    if (maxHR < 120) {
      maxHR = 120;
    }
    var sample = hrIterator.next();
    var barHeight;
    var position = 0;
    dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_BLACK);
    while (sample != null && position < params[:hrSteps]) {
	  if (sample.heartRate != ActivityMonitor.INVALID_HR_SAMPLE) {
	    hrString = "" + sample.heartRate;
	    barHeight = (((sample.heartRate - minHR).toFloat() / (maxHR - minHR).toFloat()) * 21 + 2).toNumber();
        dc.setColor(colors[:HRcolorLine], Gfx.COLOR_BLACK);
        dc.fillRectangle(params[:hrPosX] + position * 2, params[:hrPosY] + (25 - barHeight), 2, 2);
	    dc.setColor(colors[:HRcolorBar], Gfx.COLOR_BLACK);
	    dc.fillRectangle(params[:hrPosX] + position * 2, params[:hrPosY] + 2 + (25 - barHeight), 2, barHeight);
	  }
	  sample = hrIterator.next();
      position++;	
    }
  }
	
	// Called when this View is removed from the screen. Save the
	// state of this View here. This includes freeing resources from
	// memory.
	function onHide() {
	}
	
	// The user has just looked at their watch. Timers and animations may be started here.
	function onExitSleep() {
	}
	
	// Terminate any active timers and prepare for slow updates.
	function onEnterSleep() {
	}
	
  function centimetersToMetersOrKm(value) {
  
    if (distanceUnits == Sys.UNIT_STATUTE) {
        value = (value / 16000).toNumber();
        if (value > 90) {
          value = (value / 10).toNumber();
          return value + " m";
        }
        value = (value.toFloat() / 10);
        return value.format("%.1f") + " m";
    } else {
 
	    value = (value / 100).toNumber();
	    if (value < 1000) {
	      return value + " m";
	    }
	    if (value > 9999) {
	      value = (value / 1000).toNumber();
	      return value + " km";
	    }
	    value = (value / 100).toNumber();
	    value = (value.toFloat() / 10);
	    return value.format("%.1f") + " km";
	 }
  }
  
  function formatTime(hour, min, arr) {
    var ampm = "";
    var showHour = hour;
    if (!systemSettings.is24Hour) {
      if (hour == 0) {
        showHour = 12;
        ampm = "a";
      } else if (hour < 12) {
        showHour = hour;
        ampm = "a";
      } else if (hour == 12) {
        showHour = 12;
        ampm = "p";
      } else if (hour > 12) {
        showHour = hour - 12;
        ampm = "p";
      }
    }
    if (arr) {
      var longAMPM = "";
      switch (ampm) {
        case "a":
          longAMPM = "A";
          break;
        case "p":
          longAMPM = "P";
          break;
      }
      return [showHour + ":" + min.format("%02d"), longAMPM];
    } else {
      return showHour + ":" + min.format("%02d") + ampm;
    }
  }
  
  function degreesToRadians(degs) {
    var rads = [Math.toRadians(degs[0].toDouble()), Math.toRadians(degs[1].toDouble())];
    return rads;
  } 
}







