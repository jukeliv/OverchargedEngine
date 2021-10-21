package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

class Effects extends FlxSprite{

    public function new(?type:String){
        var tex = Paths.getSparrowAtlas('effects_spr');

        width = FlxG.width;
        height = FlxG.height;

        switch(type){
            case 'TV':
                frames = tex;

                animation.addByPrefix('idle', 'tv_old idle', 24);
                animation.addByPrefix('selected', 'tv_old selected', 24);
                animation.play('idle');
            default:
                visible = false;
        }
    }
}