package;

import flixel.FlxSprite;

class SpriteUtil {
    static public function scrollFactor(spr:FlxSprite,x:Float,y:Float)
    {
        spr.scrollFactor.x = x;
        spr.scrollFactor.y = y;
    }
}