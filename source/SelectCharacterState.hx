package;

import flixel.FlxSprite;

class SelectCharacterState extends MusicBeatState{
    override function create() {
        super.create();
        var text:Alphabet = new Alphabet(0, 500,'Select Your Character',true,false);
        text.isMenuItem = true;
        add(text);

        var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);
    }

    public override function update(elapsed:Float){
        super.update(elapsed);

        
    }
}