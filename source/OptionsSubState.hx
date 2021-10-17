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

	var grpOptions:FlxTypedGroup<FlxSprite>;

	var description:FlxText = new FlxText(0,0,0,null,32).setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

	var textStateItems:Array<String> = [
		(''+FlxG.save.data.downscroll),
		(''+FlxG.save.data.antialias)
	];

	var stateShit:FlxText = new FlxText(700,900,0,null,32);

	public function new()
	{
		super();

		description.screenCenter();
		description.y += 1300;
		description.scrollFactor.set();
		add(description);

		stateShit.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		add(stateShit);

		grpOptions = new FlxTypedGroup<FlxSprite>();
		add(grpOptions);

		var tex = Paths.getSparrowAtlas('Options_Menu_Assets','preload');

		for (i in 0...textMenuItems.length)
		{
			var options:FlxSprite = new FlxSprite(20, 60 + (i * 160) + 100);
			options.frames = tex;
			options.animation.addByPrefix('idle',(textMenuItems[i] + ' Idle'));
			options.animation.addByPrefix('selected',(textMenuItems[i] + ' Selected'));
			options.ID = i;
			grpOptions.add(options);
		}


	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		stateShit.text = textStateItems[curSelected].toString();

		if (controls.UP_P)
			FlxG.sound.play(Paths.sound('scrollMenu','preload'));
			changeItem(-1);

		if (controls.DOWN_P)
			FlxG.sound.play(Paths.sound('scrollMenu','preload'));
			changeItem(1);

		if (controls.BACK)
			FlxG.switchState(new MainMenuState());

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
	function changeItem(huh:Int){
		curSelected += huh;
		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;
		if (curSelected >= textMenuItems.length)
			curSelected = 0;

		grpOptions.forEach(function(spr:FlxSprite){
			if (spr.ID == curSelected)
				spr.animation.play('selected');
			else
				spr.animation.play('idle');
		});

		switch(textMenuItems[curSelected]){
			case 'DownScroll':
				description.text = 'Toggle Downscroll';
			case 'Antialiasing':
				description.text = 'Toggle Antialiasing';	
		}
	}
}