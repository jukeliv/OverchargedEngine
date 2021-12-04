package;

import flixel.tweens.FlxEase;
import flixel.FlxG;
import flixel.tweens.FlxTween;

class CameraTweens
{
    public static function tweenIn(from:Float,to:Float,dur:Float) {
        FlxG.camera.zoom = 2.5;
        FlxG.camera.angle = from;
        FlxTween.tween(FlxG.camera,{angle: to,zoom: 1},Math.abs(dur),{ease: FlxEase.elasticInOut});
    }

    public static function tweenOut(from:Float,to:Float,dur:Float) {
        FlxG.camera.zoom = 1;
        FlxG.camera.angle = from;
        FlxTween.tween(FlxG.camera,{angle: to,zoom: 2.5},Math.abs(dur),{ease: FlxEase.elasticInOut});
    }

    public static function tweenInS(){
        FlxG.sound.play(Paths.sound('transition'));
        tweenIn(180,0,0.8);
    }
}