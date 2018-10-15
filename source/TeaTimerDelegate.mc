using Toybox.WatchUi;

var timeRemaining;

class TeaTimerDelegate extends WatchUi.BehaviorDelegate {
    var teaTimer = new Timer.Timer();
    var isBrewing = false;    
    
    function initialize() {
        timeRemaining = Application.Storage.getValue("brewingTime");
        
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        if (!isBrewing) {
            teaSelect();
        }
    }
    
    function onKey(keyEvent) {
        if (keyEvent.getKey() == WatchUi.KEY_ENTER && !isBrewing) {
            startTimer();
        }
        
        return true;
    }
    
    function gettimeRemaining() {
        return $.timeRemaining;
    }
    
    function startTimer() {
        $.timeRemaining = Application.Storage.getValue("brewingTime");
        isBrewing = true;
        
        WatchUi.requestUpdate();
        
        teaTimer.start(method(:timerCallback), 1000, true);
    }
    
    function timerCallback() {
        $.timeRemaining--;
        if ($.timeRemaining == 0) {
            finishTimer();
        }
        
        WatchUi.requestUpdate();
    }
    
    function finishTimer() {
        teaTimer.stop();
        resetTime();
        notify();
    }
    
    // Reset the time remaing to be the initial brewing time
    function resetTime() {        
        var brewTime = Application.Storage.getValue("brewingTime");
        isBrewing = false;
        
        $.timeRemaining = brewTime;
        WatchUi.requestUpdate();
    }
    
    function notify() {
        if (Attention has :vibrate) {
            var vibrationPattern = [
                new Attention.VibeProfile(50, 1000), // On for 1 second
                new Attention.VibeProfile(0, 500),  // Off for 1/2 second
                new Attention.VibeProfile(50, 1000), // On for 1 second
                new Attention.VibeProfile(0, 500),  // Off for 1/2 second
                new Attention.VibeProfile(50, 1000)  // on for 1 second
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