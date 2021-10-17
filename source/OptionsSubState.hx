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
		'Antialiasing'];

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

		grpOptionsTexts = new FlxTypedGroup<FlxSprite>();
		add(grpOptionsTexts);

		var tex = Paths.getSparrowAtlas('Options_Menu_Assets','preload');

		for (i in 0...textMenuItems.length)
		{
			var optionShit:FlxSprite = new FlxSprite(20, 20 + (i * 50), 0, textMenuItems[i], 32);
			optionsShit.frames = tex;
			optionShit.animation.addByPrefix('idle',(textMenuItems[i] + ' Idle'));
			optionShit.animation.addByPrefix('selected',(textMenuItems[i] + ' Selected'));
			optionShit.ID = i;
			grpOptionsTexts.add(optionShit);
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

		FlxSprite.forEach(function(spr:FlxSprite){

		});

		grpOptionsTexts.forEach(function(spr:FlxSprite)
		{
			if (spr.ID == curSelected)
				spr.animation.play('selected');
			else
				spr.animation.play('idle');
		});

		switch(textMenuItems[curSelected]){
			case 'DownScroll':
				description = 'Toggle Downscroll';
			case 'Antialiasing':
				description = 'Toggle Antialiasing';
			
		}

		if (controls.ACCEPT)
		{
			trace(textMenuItems[curSelected] + ':');
			FlxG.sound.play(Paths.sound('confirmMenu','preload'));
			switch (textMenuItems[curSelected])
			{
				case 'DownScroll':
					FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
					trace(FlxG.save.data.downscroll);

				case 'Antialiasing':
					FlxG.save.data.antialias = !FlxG.save.data.antialias;
					trace(FlxG.save.data.antialias);
			}
		}
	}
}