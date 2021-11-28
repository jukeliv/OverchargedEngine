	package;

	import OptionsCategory.OptionsCategory;
	import flixel.util.FlxTimer;
	import flixel.FlxSubState;
	import flixel.FlxG;
	import flixel.FlxSprite;
	import flixel.group.FlxGroup.FlxTypedGroup;
	import flixel.text.FlxText;
	import flixel.util.FlxColor;
	import flixel.tweens.FlxTween;

	class OptionsSubState extends MusicBeatSubstate
	{
		var textMenuItems:Array<String> = ['Controls','Optimization','Customizable Variables'];

		var selector:FlxSprite;
		var curSelected:Int = 0;

		public static var acceptInput:Bool;

		var grpOptionsTexts:FlxTypedGroup<Alphabet>;
		var descText:FlxText;

		public function new()
		{
			super();

			descText = new FlxText();
			descText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
			descText.screenCenter();
			descText.y += 320;
			descText.x -= 120;
			add(descText);

			updateDesc('KeyBlinds Menu');

			grpOptionsTexts = new FlxTypedGroup<Alphabet>();
			add(grpOptionsTexts);

			for (i in 0...textMenuItems.length)
			{
				var optionText:Alphabet = new Alphabet(20, 20 + (i * 50), textMenuItems[i], true,false);
				optionText.screenCenter(X);
				optionText.isMenuItem = true;
				optionText.targetY = i;
				optionText.extraY = -160;
				optionText.extraX = 60;
				optionText.ID = i;

				if(optionText.ID == 0)
					optionText.color = FlxColor.YELLOW;

				grpOptionsTexts.add(optionText);
			}
		}

		override function update(elapsed:Float)
		{
			super.update(elapsed);

			if (controls.UP_P)
				cum(-1);

			if (controls.DOWN_P)
				cum(1);

			if(controls.BACK){
				trace('Back to the main menu ugu');
				FlxG.switchState(new MainMenuState());
				save();
			}

			if (controls.ACCEPT)
			{
				switch (textMenuItems[curSelected])
				{
					case "Controls":
						switchSubState(new KeyBindMenu(),false);
				}
			}
		}
		function updateDesc(desc:String){
			descText.text = desc;
			FlxG.sound.play(Paths.sound('scrollMenu'));
			trace('Description Updated To: ' + descText.text);
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

			function cum(huh:Int){
				descText.screenCenter(X);

				curSelected += huh;

				FlxG.sound.play(Paths.sound('scrollMenu'));

				if (curSelected < 0)
					curSelected = textMenuItems.length - 1;

				if (curSelected >= textMenuItems.length)
					curSelected = 0;

				switch (textMenuItems[curSelected])
				{
					case "Controls":
						updateDesc('KeyBlinds Menu');
					case "Optimization":
						updateDesc('Optimization Menu: Change some variables \n if you dont have a bad pc dont touch this to much');
					case 'Scroll Speed':
						updateDesc('Scroll Speed: ' + Options.scrollSpeed);
					case 'Offset':
						updateDesc('Offset: ' + Options.offset);
					case 'Show FPS Counter':
						updateDesc('Show FPS Counter : ' + Std.string(Options.fpsCounter?'Yes':'No'));
				}

				grpOptionsTexts.forEach(function(txt:Alphabet)
					{
						if (txt.ID == curSelected)
							txt.color = FlxColor.YELLOW;
						else
							txt.color = FlxColor.WHITE;
					});
			}

			function save(){
				FlxG.save.data.middleScroll = Options.middleScroll;
				FlxG.save.data.offset = Options.offset;
				FlxG.save.data.scrollSpeed = Options.scrollSpeed;
				FlxG.save.data.fpsCounter = Options.fpsCounter;
			}
	}