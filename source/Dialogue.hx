package;

import flixel.FlxSprite;
import flixel.text.FlxText;

class Dialogue extends FlxSprite{

    public static var cur_dialogue = 0;
    public function new(dialogueShit:Array<String> = ['._.', 'XD'],?char:Array<String>,?style:Int){
        var charSpr = new FlxSprite();
        if(char == null)
            charSpr.loadGraphic(Paths.image('default_char','char'));
        else
            charSpr.loadGraphic(Paths.image(char[cur_dialogue] + '_char'));



        var tex;
        switch(style){
            case 1:
                tex = Paths.getSparrowAtlas('sempai_Dialogues');
            default:
                tex = Paths.getSparrowAtlas('default_Dialogues');
        }

        frames = tex;
    }
}