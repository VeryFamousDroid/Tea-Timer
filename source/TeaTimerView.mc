using Toybox.WatchUi;
using Toybox.Graphics as Gfx;

class TeaTimerView extends WatchUi.View {
    var selectedTea;
    
    function getTimeRemaining() {
        var timeRemaining = Application.Storage.getValue("timeRemaining");
        if (timeRemaining == null) {
            timeRemaining = selectedTea["time"];  
            Application.Storage.setValue("timeRemaining", timeRemaining); 
        }

        return timeRemaining;
    }
    
    function displayRemainingTime() {
        var timeRemaining = getTimeRemaining();
        var minutes = timeRemaining / 60;
        var seconds = timeRemaining % 60;
        
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
        
        var stepsView = View.findDrawableById("TeaInfo");
        stepsView.setFont(font);
        stepsView.setColor(Gfx.COLOR_BLACK);
        stepsView.setText(stepsString);
    }
    
    function setButtonFont() {
        var font = WatchUi.loadResource(Rez.Fonts.Carlito);
        
        var stepsView = View.findDrawableById("ButtonLabel");
        stepsView.setFont(font);
        stepsView.setColor(Gfx.COLOR_WHITE);
    }
    
    
    
    function loadSelectedTea() {
        var teaID = Application.Storage.getValue("selectedTeaID");
        if (teaID == null) {
            teaID = 0;        
        }
        var teas = WatchUi.loadResource(Rez.JsonData.Teas);
        
        selectedTea = teas[teaID];
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
    }

    // Update the view
    function onUpdate(dc) {
        loadSelectedTea();
        displayRemainingTime();
        displayTeaInfo();
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
