using Toybox.System;
using Toybox.WatchUi;


class Wine_RewarderDelegate extends WatchUi.BehaviorDelegate {
    
    private var _parentView as Wine_RewarderView;
    var isBeer;
    //! Constructor
    //! @param view The InputView to operate on
    public function initialize(view) {
        BehaviorDelegate.initialize();
        _parentView = view;
        isBeer = false;
    }

    function onSelect() {
        
        if (isBeer)
        {
            isBeer = false;
        }
        else
        {
            isBeer = true;
        }
        
        _parentView.ChangeView(isBeer);

        return true;
    }
}