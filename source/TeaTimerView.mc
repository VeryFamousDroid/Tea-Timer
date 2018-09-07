using Toybox.WatchUi;
using Toybox.Graphics as Gfx;

class TeaTimerView extends WatchUi.View {
    function displayRemainingTime() {
        var timeString = "4:00";
        var font = WatchUi.loadResource(Rez.Fonts.Carlito_Large);
        
        var timeView = View.findDrawableById("TimeRemaining");
        timeView.setFont(font);
        timeView.setColor(Gfx.COLOR_BLACK);
        timeView.setText(timeString);
    }
    
    function displayTeaInfo() {
        var stepsString = "Black, 212 deg";
        var font = WatchUi.loadResource(Rez.Fonts.Carlito);
        
        var stepsView = View.findDrawableById("TeaInfo");
        stepsView.setFont(font);
        stepsView.setColor(Gfx.COLOR_BLACK);
        stepsView.setText(stepsString);
    }
    
    function initialize() {
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
