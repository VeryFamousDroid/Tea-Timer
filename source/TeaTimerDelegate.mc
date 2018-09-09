using Toybox.WatchUi;

class TeaTimerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function teaSelect() {
        var menu = new WatchUi.Menu2({:title => "Tea Menu"});
        
        var teas = WatchUi.loadResource(Rez.JsonData.Teas);
        
        var degreeSymbol = StringUtil.utf8ArrayToString([194,176]);
        
        for (var i=0; i<teas.size(); i++) {
            menu.addItem(
                new MenuItem(
                    teas[i]["name"],
                    Lang.format("$1$$2$F, $3$ min", [teas[i]["temp"], degreeSymbol,  teas[i]["time"]]),
                    i,
                    {}
                )
            );
        }
        
        WatchUi.pushView(menu, new TeaTimerMenuDelegate(), WatchUi.SLIDE_LEFT);
        
        return true;
    }

}