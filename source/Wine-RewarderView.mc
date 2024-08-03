import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.UserProfile;
using Toybox.Time.Gregorian;

class Wine_RewarderView extends WatchUi.View {
    private var _glasses_earned;
    
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        _glasses_earned = findDrawableById("GlassesEarned");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        updateGlasses();
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function updateGlasses() as Void {
        var profile = UserProfile.getProfile();
        var info = ActivityMonitor.getInfo();

        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var profileAge = today.year - profile.birthYear;


        // ######################################################      
        // Calculate: Basal Metabolic Rate (BMR)
        // Ref: https://www.omnicalculator.com/health/simple-calorie-intake
        // Women: BMR (kcal/day) = 10 × weight (kg) + 6.25 × height (cm) – 5 × age (years) – 161
        // Men:   BMR (kcal/day) = 10 × weight (kg) + 6.25 × height (cm) – 5 × age (years) + 5
        var gender_adjustment = -161;
        if (profile.gender == UserProfile.GENDER_MALE)
        {
            gender_adjustment = 5;
        }

        var BMR = 10.0 * (profile.weight / 1000) + 6.25 * profile.height - 5 * profileAge + gender_adjustment;
        

        // ######################################################      
        // Calculate: Physical Activity Level (PAL)
        // PAL = 1.2     Little or no exercise.
        // PAL = 1.4     Light exercise (1-2 times/week).
        // PAL = 1.6     Moderate exercise (2-3 times/week).
        // PAL = 1.75    Hard exercise (3-5 times/week).
        // PAL = 2.0     Physical job/Hard exercise (6-7 times/week).
        var PAL = 1.4;


        // ######################################################      
        // Calculate: Total Daily Calorie Requirement  (TDEE)
        // TDEE (kcal/day) = BMR × PAL
        var TDEE = BMR * PAL;


        // ######################################################
        // Calculate: Calories above TDEE
        var calories_surplus = info.calories.toFloat() - TDEE;
        if (calories_surplus < 0)
        {
            calories_surplus = 0;
        }       
        

        var wineglasses = Math.floor(calories_surplus / 83.0).toNumber();


        // ######################################################
        // Special occasions

        // Friday and saturday
        // 1 to 7. 1 = Sunday, 2 = Monday, ..., 7 = Saturday

        if (today.day_of_week == 6)
        {
            wineglasses = wineglasses + 1;
        }
        else if (today.day_of_week == 7)
        {
            wineglasses = wineglasses + 1;
        }

        // ######################################################
        // Show to user
        var formattedValue = wineglasses.toString();
        _glasses_earned.setText(formattedValue);
    }
}
