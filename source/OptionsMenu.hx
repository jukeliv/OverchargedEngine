package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import states.options.PreferencesMenuState;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var optionsStrings:Array<String> = ['Controls','Preferences'];

	private var grpControls:FlxTypedGroup<Alphabet>;

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...optionsStrings.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (60 * i) + 60, optionsStrings[i].toLowerCase(), true, false);
			controlLabel.isMenuItem = true;
			controlLabel.targetY = i;
			if(i == 0){
				controlLabel.color = FlxColor.YELLOW;
				controlLabel.alpha = 1;
			}
			else{
				controlLabel.color = FlxColor.WHITE;
				controlLabel.alpha = 0.6;
			}
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			switch(optionsStrings[curSelected]){
				case 'Controls':
					FlxG.state.openSubState(new KeyBindMenu());
				case 'Preferences':
					FlxG.switchState(new PreferencesMenuState());
			}
		}
		else
		{
			if (controls.BACK)
				FlxG.switchState(new MainMenuState());
			if (controls.UP_P)
				changeSelection(-1);
			if (controls.DOWN_P)
				changeSelection(1);
		}
	}
	function changeSelection(change:Int = 0)
	{

		FlxG.sound.play(Paths.sound('scrollMenu'),Math.abs(1 * FlxG.save.data.masterVolume));

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			item.color = FlxColor.WHITE;

			if (item.targetY == 0)
			{
				item.color = FlxColor.YELLOW;
				item.alpha = 1;
			}
		}
	}
}