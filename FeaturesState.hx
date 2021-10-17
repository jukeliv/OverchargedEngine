import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import lime.utils.Assets;
import flixel.FlxState;

class FeaturesState extends FlxState{
    var featuresText:Alphabet;

    override function create(){
        var featuresMenuItem:Array<String> = getFeaturesShit();

        var grpFeatures:FlxTypedGroup<Alphabet>;
        add(grpFeatures);
        
        for (i in 0...featuresMenuItem.length)
        {
            var options:Alphabet = new Alphabet(20, 60 + (i * 160) + 100,featuresMenuItem[i].toString());
            options.ID = i;
            grpFeatures.add(options);
        }

        var bg:FlxSprite;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat','preload'));
		SpriteUtil.scrollFactor(bg,0,0.18);
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.visible = true;
		bg.antialiasing = true;
		bg.color = 0xE7E7E7;
		add(bg);

		var fd:FlxSprite;
		fd = new FlxSprite().loadGraphic(Paths.image('menuDegraded','preload'));
		SpriteUtil.scrollFactor(fd,0,0.18);
		fd.setGraphicSize(Std.int(fd.width * 1.1));
		fd.updateHitbox();
		fd.screenCenter();
		fd.visible = true;
		fd.antialiasing = true;
		fd.color = 0x2019FF;
		add(fd);

        super.create();
    }
    override function update(elapsed:Float){
        super.update(elapsed);


    }
    function getFeaturesShit():Array<String>
    {
            var fullText:String = Assets.getText(Paths.txt('introText'));
    
            var firstArray:Array<String> = fullText.split('\n');

            return firstArray;
    }
}