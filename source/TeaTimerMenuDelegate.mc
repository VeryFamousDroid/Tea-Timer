using Toybox.WatchUi;
using Toybox.System;

class TeaTimerMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        System.println(item.getId());
        
        // Go back to the main view
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }

}