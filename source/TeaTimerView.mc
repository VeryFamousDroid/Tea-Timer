using Toybox.WatchUi;
using Toybox.Graphics as Gfx;

class TeaTimerView extends WatchUi.View {
    var selectedTea;
    
    function resetTime() {
        var brewTime = Application.Storage.getValue("brewingTime");
        if (brewTime == null) {
            brewTime = selectedTea["time"];
        }
        
        Application.Storage.setValue("timeRemaining", brewTime);
    }
    
    function getTimeRemaining() {
        var timeRemaining = Application.Storage.getValue("timeRemaining");
        if (timeRemaining == null || timeRemaining == 0) {
            timeRemaining = selectedTea["time"];  
            Application.Storage.setValue("timeRemaining", timeRemaining); 
        }

        return timeRemaining;
    }
    
    function getBrewingTime() {
        return Application.Storage.getValue("brewingTime");
    }
    
    function displayRemainingTime() {
        var timeRemaining = getTimeRemaining();
        
        drawTime(timeRemaining);
    }
    
    function drawTime(time) {
        var minutes = time / 60;
        var seconds = time % 60;
        
        var timeString = Lang.format("$1$:$2$", [minutes, seconds.format("%02d")]);
        var font = WatchUi.loadResource(Rez.Fonts.Carlito_Large);
        
        var timeView = View.findDrawableById("TimeRemaining");
        timeView.setFont(font);
        timeView.setColor(Gfx.COLOR_BLACK);
        timeView.setText(timeString);
    }
    
    function displayTeaInfo() {
        var degreeSymbol = StringUtil.utf8ArrayToString([194,176]);
        var stepsString = Lang.format("$1$, $2$$3$F", [selectedTea["name"], selectedTea["temp"], degreeSymbol]);
        var font = WatchUi.loadResource(Rez.Fonts.Carlito);
        
        var teaView = View.findDrawableById("TeaInfo");
        teaView.setFont(font);
        teaView.setColor(Gfx.COLOR_BLACK);
        teaView.setText(stepsString);
    }
    
    function getMessage() {
        var timeRemaining = getTimeRemaining();
        var brewingTime = getBrewingTime();
        
        if (timeRemaining == brewingTime) {
            return "Select a tea";
        }
        
        return "Brewing...";
    }
    
    function displayMessage(message) {
        var font = WatchUi.loadResource(Rez.Fonts.Carlito);
        
        var msgView = View.findDrawableById("MessageLabel");
        msgView.setFont(font);
        msgView.setColor(Gfx.COLOR_BLACK);
        msgView.setText(message);
    }
    
    function setButtonFont() {
        var font = WatchUi.loadResource(Rez.Fonts.Carlito);
        
        var stepsView = View.findDrawableById("ButtonLabel");
        stepsView.setFont(font);
        stepsView.setColor(Gfx.COLOR_WHITE);
    }
    
    function hideButton() {
        return false;
    }
    
    function loadSelectedTea() {
        var teaID = Application.Storage.getValue("selectedTeaID");
        if (teaID == null) {
            teaID = 0;        
        }
        var teas = WatchUi.loadResource(Rez.JsonData.Teas);
        
        selectedTea = teas[teaID];
        Application.Storage.setValue("brewingTime", selectedTea["time"]);
    }
    
    function getArcAngle() {
        var timeRemaining = getTimeRemaining();
        var brewingTime = Application.Storage.getValue("brewingTime");        
        
        var arc_angle = (360 * timeRemaining) / brewingTime;
        
        arc_angle = 90 - arc_angle;
        if (arc_angle < 0) {
            arc_angle += 360;
        }
        
        return arc_angle;
    }
    
    function drawTimerArc(dc) {        
        var height = dc.getHeight();
        var width = dc.getWidth();
        
        var angle = getArcAngle();
                        
        dc.setColor(0x00b300, Gfx.COLOR_TRANSPARENT);
        dc.setPenWidth(10);
        
        dc.drawArc(width/2, height/2, (width/2)-5, dc.ARC_CLOCKWISE, 90, angle);              
    }
    
    function initialize() {
        loadSelectedTea();
        
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        loadSelectedTea();
        
        displayMessage(getMessage());
        displayTeaInfo();
        resetTime();
    }

    // Update the view
    function onUpdate(dc) {
        displayRemainingTime();        
        displayMessage(getMessage());
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        
        drawTimerArc(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
