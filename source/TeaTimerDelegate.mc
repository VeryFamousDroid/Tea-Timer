using Toybox.WatchUi;

class TeaTimerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        var menu = new WatchUi.Menu2({:title => "Tea Menu"});
        var delegate = new WatchUi.Menu2InputDelegate();
        
        menu.addItem(
            new MenuItem(
                "Black Tea",
                "212 deg, 4 min",
                "black",
                {}
            )
        );
        
        menu.addItem(
            new MenuItem(
                "Green Tea",
                "175 deg, 2 min",
                "green",
                {}
            )
        );
        
        WatchUi.pushView(menu, new TeaTimerMenuDelegate(), WatchUi.SLIDE_UP);
        
        return true;
    }

}