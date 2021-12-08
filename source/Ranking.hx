package;
import flixel.FlxG;

class Ranking {
    static public function UpdateRanking():String{
        var ranking:String = '?';

        if(PlayState.perfects >= 1 && PlayState.sicks == 0 && PlayState.goods == 0 && PlayState.mehs == 0 && PlayState.bads == 0 && PlayState.fucks == 0 && PlayState.shits == 0 && PlayState.misses == 0)
            ranking = 'YOU ROCK!!(Perfect)';
        else if(PlayState.perfects >= 1 && PlayState.sicks >= 1 && PlayState.goods == 0 && PlayState.mehs == 0 && PlayState.bads == 0 && PlayState.fucks == 0 && PlayState.shits == 0 && PlayState.misses == 0)
            ranking = 'Full Combo (sicks/perfects)';
        else if(PlayState.sicks >= 1 && PlayState.perfects == 0 && PlayState.goods == 0 && PlayState.mehs == 0 && PlayState.bads == 0 && PlayState.fucks == 0 && PlayState.shits == 0 && PlayState.misses == 0)
            ranking = 'Full Combo (sicks)';
        else if(PlayState.goods >= 1 && PlayState.mehs == 0 && PlayState.bads == 0 && PlayState.fucks == 0 && PlayState.shits == 0  && PlayState.misses == 0)
            ranking = 'Full Combo (Goods)';
        else if(PlayState.misses == 0)
            ranking = 'Regular Full Combo';
        else if(PlayState.misses > 10)
            ranking = 'Fucked';
        else
            ranking = 'N/A';

        return ranking;
    }
    static public function GenerateRating(noteDiff:Float,?saveFrames:Float = 0):String{
        var daRating:String = 'perfect';
        if (noteDiff > Conductor.safeZoneOffset * 0.9 + saveFrames)
			daRating = 'awfull';
		else if (noteDiff > Conductor.safeZoneOffset * 0.85 + saveFrames)
			daRating = 'shit';
		else if (noteDiff > Conductor.safeZoneOffset * 0.75 + saveFrames)
			daRating = 'fuck';
		else if (noteDiff > Conductor.safeZoneOffset * 0.6 + saveFrames)
			daRating = 'bad';
		else if (noteDiff > Conductor.safeZoneOffset * 0.55 + saveFrames)
			daRating = 'meh';
		else if (noteDiff > Conductor.safeZoneOffset * 0.2 + saveFrames)
			daRating = 'good';
		else if (noteDiff > Conductor.safeZoneOffset * 0.1 + saveFrames)
			daRating = 'sick';

            return daRating;
    }
}