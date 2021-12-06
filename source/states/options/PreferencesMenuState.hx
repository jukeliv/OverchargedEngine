package states.options;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;

class PreferencesMenuState extends MusicBeatState {
    var textMenuItems:Array<String> = ['Scroll Speed','Antialiasing'];
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<Alphabet>;

    var bf:Character = new Character(0,0);

	override function create()
	{
        super.create();

        var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		//load values
		if(FlxG.save.data.scrollSpeed != null)
			Options.scrollSpeed = FlxG.save.data.scrollSpeed;
		if(FlxG.save.data.antialiasing != null)
			Options.antialiasing = FlxG.save.data.antialiasing;

		grpOptionsTexts = new FlxTypedGroup<Alphabet>();
		add(grpOptionsTexts);

		for (i in 0...textMenuItems.length)
		{
            var controlLabel:Alphabet = new Alphabet(0, (50 * i) + 30, textMenuItems[i].toLowerCase(), true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
            if(controlLabel.ID == 0){
				controlLabel.color = FlxColor.YELLOW;
			}
			grpOptionsTexts.add(controlLabel);
		}

        bf.screenCenter();
        bf.x += 350;
        bf.flipX = true;
        bf.visible = false;
        add(bf);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        bf.antialiasing = Options.antialiasing;

		if (controls.UP_P)
			changeSelection(-1);

		if (controls.DOWN_P)
			changeSelection(1);

		if(controls.LEFT_P){
			switch(textMenuItems[curSelected]){
				case 'Scroll Speed':
					Options.scrollSpeed-=0.1;
			}
		}
		if(controls.RIGHT_P){
			switch(textMenuItems[curSelected]){
				case 'Scroll Speed':
					Options.scrollSpeed+=0.1;
			}
		}
        if(controls.ACCEPT){
            switch(textMenuItems[curSelected]){
                case 'Antialiasing':
                    Options.antialiasing = !Options.antialiasing;
            }
        }		

		if(controls.BACK){
			trace('Back to the main menu');
			FlxG.switchState(new OptionsMenu());
			Options.save();
		}

		function switchSubState(subState:FlxSubState,shish:Bool){
			if(shish)
				FlxG.sound.play(Paths.sound('confirmMenu'));

			grpOptionsTexts.forEach(function(txt:Alphabet)
			{
				FlxTween.tween(txt,{alpha: 0});
			});
			new FlxTimer().start(0.45,function(tmr:FlxTimer){
				FlxG.state.closeSubState();
				FlxG.state.openSubState(subState);
				trace('goto  ' + subState);
			});
		}
    }

        public function changeSelection(huh:Int){
			curSelected += huh;

			FlxG.sound.play(Paths.sound('scrollMenu'));

			if (curSelected < 0)
				curSelected = textMenuItems.length - 1;

			if (curSelected >= textMenuItems.length)
				curSelected = 0;

            if(textMenuItems[curSelected] == 'Antialiasing')
                bf.visible = true;
            else
                bf.visible = false;

			grpOptionsTexts.forEach(function(txt:Alphabet)
				{
					if (txt.ID == curSelected)
						txt.color = FlxColor.YELLOW;
					else
						txt.color = FlxColor.WHITE;
				});
		}
}