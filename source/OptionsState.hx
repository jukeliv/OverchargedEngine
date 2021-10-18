package;

import Discord.DiscordClient;
import flixel.FlxState;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.Lib;
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
import lime.app.Application;
import lime.system.DisplayMode;
import Controls.KeyboardScheme;
import openfl.display.FPS;

class OptionsState extends MusicBeatState
{
	var optionsMenuItems:Array<String> = [
		'Antialiasing'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptions:FlxTypedGroup<FlxSprite>;

	var description:FlxText = new FlxText(0,0,0,null,32).setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

	var textStateItems:Array<String> = [
		(''+FlxG.save.data.dfjk),
		(''+FlxG.save.data.antialias)
	];

	var stateShit:FlxText = new FlxText(700,900,0,null,32);

	var menuItems:FlxTypedGroup<FlxSprite>;

	override function create()
	{
		var bg:FlxSprite;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat','preload'));
		SpriteUtil.scrollFactor(bg,0,0.18);
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		bg.color = 0xE7E7E7;
		add(bg);

		var fd:FlxSprite;
		fd = new FlxSprite().loadGraphic(Paths.image('menuDegraded','preload'));
		SpriteUtil.scrollFactor(fd,0,0.18);
		fd.setGraphicSize(Std.int(fd.width * 1.1));
		fd.updateHitbox();
		fd.screenCenter();
		fd.antialiasing = true;
		fd.color = 0x2019FF;
		add(fd);

		/*description.screenCenter();
		description.y += 1300;
		description.scrollFactor.set();
		add(description);*/

		stateShit.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		//add(stateShit);

		grpOptions = new FlxTypedGroup<FlxSprite>();
		add(grpOptions);

		for (i in 0...optionsMenuItems.length)
		{
			var options:FlxSprite = new FlxSprite(20, 60 + (i * 160) + (optionsMenuItems.length * 100 / 3),optionsMenuItems[i].toString());
            options.frames = Paths.getSparrowAtlas('Options_Menu_Assets','preload');
            options.animation.addByPrefix('idle',optionsMenuItems[i]+' Idle');
            options.animation.addByPrefix('idle',optionsMenuItems[i]+' Selected');
			options.ID = i;
			grpOptions.add(options);
		}

        #if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Options Menu",null);
		#end

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		//stateShit.text = textStateItems[curSelected].toString();

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
			trace(optionsMenuItems[curSelected] + ':');
			FlxG.sound.play(Paths.sound('confirmMenu','preload'));

            grpOptions.forEach(function(spr:FlxSprite){
                if(spr.ID == curSelected){
                    switch(spr.ID){
                        case 0:
                            FlxG.save.data.antialias = !FlxG.save.data.antialias;
                    }
                }
            });
        }
			if (controls.BACK)
				FlxG.switchState(new MainMenuState());

        grpOptions.forEach(function(spr:FlxSprite){
            if(spr.ID == curSelected){
                switch(spr.ID){
                    case 0:
                        spr.animation.play('selected');
                }
            }
            else
                spr.animation.play('idle');
        });
	}
	function changeItem(huh:Int){
		curSelected += huh;
		if (curSelected < 0)
			curSelected = optionsMenuItems.length - 1;
		if (curSelected >= optionsMenuItems.length)
			curSelected = 0;

		grpOptions.forEach(function(spr:FlxSprite){
			if (spr.ID == curSelected)
				spr.animation.play('selected');
			else
				spr.animation.play('idle');
		});

		switch(optionsMenuItems[curSelected]){
			case 'Antialiasing':
				description.text = 'Toggle Antialiasing';	
		}
	}
}
