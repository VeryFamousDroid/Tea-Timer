using Toybox.WatchUi;

class TeaTimerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new TeaTimerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}