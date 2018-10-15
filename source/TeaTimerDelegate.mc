using Toybox.WatchUi;

class TeaTimerDelegate extends WatchUi.BehaviorDelegate {
    var teaTimer = new Timer.Timer();
    var isBrewing = false;
    
    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        teaSelect();
    }
    
    function onKey(keyEvent) {
        if (keyEvent.getKey() == WatchUi.KEY_ENTER && !isBrewing) {
            startTimer();            
            return true;
        }
        
        return false;
    }
    
    function startTimer() {
        System.println("Starting timer...");
        
        var timeRemaining = Application.Storage.getValue("brewingTime");
        isBrewing = true;
        
        Application.Storage.setValue("timeRemaining", timeRemaining);
        WatchUi.requestUpdate();
        
        teaTimer.start(method(:timerCallback), 1000, true);
    }
    
    function timerCallback() {
        var timeRemaining = Application.Storage.getValue("timeRemaining");
        timeRemaining--;
        if (timeRemaining == 0) {
            teaTimer.stop();
            resetTime();
            notify();
        }
        
        Application.Storage.setValue("timeRemaining", timeRemaining);
        WatchUi.requestUpdate();
    }
    
    // Reset the time remaing to be the initial brewing time
    function resetTime() {        
        var brewTime = Application.Storage.getValue("brewingTime");
        isBrewing = false;
        
        Application.Storage.setValue("timeRemaining", brewTime);
        WatchUi.requestUpdate();
    }
    
    function notify() {
        if (Attention has :vibrate) {
            var vibrationPattern = [
                new Attention.VibeProfile(50, 2000), // On for two seconds
                new Attention.VibeProfile(0, 2000),  // Off for two seconds
                new Attention.VibeProfile(50, 2000), // On for two seconds
                new Attention.VibeProfile(0, 2000),  // Off for two seconds
                new Attention.VibeProfile(50, 2000)  // on for two seconds 
            ]; 
            
            Attention.vibrate(vibrationPattern); 
        }
    }
    
    function teaSelect() {
        var menu = new WatchUi.Menu2({:title => "Tea Menu"});
        
        var teas = WatchUi.loadResource(Rez.JsonData.Teas);
        
        var degreeSymbol = StringUtil.utf8ArrayToString([194,176]);
        
        for (var i=0; i<teas.size(); i++) {
            var teaTimeMinutes = teas[i]["time"] / 60;
            
            menu.addItem(
                new MenuItem(
                    teas[i]["name"],
                    Lang.format("$1$$2$F, $3$ min", [teas[i]["temp"], degreeSymbol,  teaTimeMinutes]),
                    i,
                    {}
                )
            );
        }
        
        WatchUi.pushView(menu, new TeaTimerMenuDelegate(), WatchUi.SLIDE_LEFT);
        
        return true;
    }

}