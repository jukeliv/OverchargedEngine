package;

import flixel.FlxSprite;

class RatingState extends MusicBeatState{
    override function create():Void {
        super.create();
        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
        bg.screenCenter();
        bg.setGraphicSize(Std.int(bg.width * 1.3));
        add(bg);

        var ranking:FlxSprite = new FlxSprite(0,300).loadGraphic(Paths.image('ranking-' + PlayState.daRanking));
        ranking.screenCenter(X);
        add(ranking);
    }
}