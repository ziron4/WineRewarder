import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class Wine_RewarderApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        var view = new Wine_RewarderView();
        var delegate = new Wine_RewarderDelegate(view);
        return [view, delegate];
     }

}

function getApp() as Wine_RewarderApp {
    return Application.getApp() as Wine_RewarderApp;
}