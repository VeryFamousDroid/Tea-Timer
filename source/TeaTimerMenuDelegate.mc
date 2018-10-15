using Toybox.WatchUi;
using Toybox.System;

class TeaTimerMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        Application.Storage.setValue("selectedTeaID", item.getId());
        
        var teas = WatchUi.loadResource(Rez.JsonData.Teas);        
        var selectedTea = teas[item.getId()];  
        
        Application.Storage.setValue("brewingTime", selectedTea["time"]);
        Application.Storage.setValue("timeRemaining", selectedTea["time"]);
        
        // Go back to the main view
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }

}