package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = [
		'DownScroll',
		'Antialiasing',
		'ScrollSpeed'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	var description:String;

	var textStateItems:Array<String> = [
		(''+FlxG.save.data.downscroll),
		(''+FlxG.save.data.antialias),
		(''+FlxG.save.data.scrollSpeed)
	];

	var stateShit:FlxText = new FlxText(700,900,0,null,32);

	public function new()
	{
		super();

		stateShit.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		add(stateShit);

		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		add(grpOptionsTexts);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, textMenuItems[i], 32);
			optionText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		stateShit.text = textStateItems[curSelected].toString();

		if (controls.UP_P)
			FlxG.sound.play(Paths.sound('scrollMenu','preload'));
			curSelected -= 1;

		if (controls.DOWN_P)
			FlxG.sound.play(Paths.sound('scrollMenu','preload'));
			curSelected += 1;

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		if (controls.BACK)
			FlxG.switchState(new MainMenuState());

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
			else
				txt.color = FlxColor.WHITE;
		});

		switch(textMenuItems[curSelected]){
			case 'DownScroll':
				description = 'Toggle Downscroll';
			case 'Antialiasing':
				description = 'Toggle Antialiasing';
			
		}

		if (controls.ACCEPT)
		{
			FlxG.sound.play(Paths.sound('confirmMenu','preload'));
			switch (textMenuItems[curSelected])
			{
				case 'DownScroll':
					FlxG.save.data.downscroll = !FlxG.save.data.downscroll;

				case 'Antialiasing':
					FlxG.save.data.antialias = !FlxG.save.data.antialias;
			}
		}
	}
}