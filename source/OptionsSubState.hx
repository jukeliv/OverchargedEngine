	package;

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
		var textMenuItems:Array<String> = ['Middle Scroll','Controls','Scroll Speed','Offset','Show FPS Counter'];
		var textMenuDesc:Array<String>;

		var selector:FlxSprite;
		var curSelected:Int = 0;

		public static var acceptInput:Bool;

		var grpOptionsTexts:FlxTypedGroup<FlxText>;
		var descText:FlxText;

		public function new()
		{
			super();

			//load values
			if(FlxG.save.data.middleScroll != null)
				Options.middleScroll = FlxG.save.data.middleScroll;
			if(FlxG.save.data.scrollSpeed != null)
				Options.scrollSpeed = FlxG.save.data.scrollSpeed;
			if(FlxG.save.data.offset != null)
				Options.offset = FlxG.save.data.offset;
			if(FlxG.save.data.fpsCounter != null)
				Options.fpsCounter = FlxG.save.data.fpsCounter;

			descText = new FlxText();
			descText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER);
			descText.screenCenter();
			descText.y += 320;
			descText.x -= 120;
			add(descText);

			updateDesc('Middle Scroll: ' + Options.middleScroll);

			grpOptionsTexts = new FlxTypedGroup<FlxText>();
			add(grpOptionsTexts);

			for (i in 0...textMenuItems.length)
			{
				var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, textMenuItems[i], 32);
				optionText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, null,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
				optionText.borderSize = 2;
				optionText.screenCenter(X);
				optionText.ID = i;
				if(optionText.ID == 0){
					optionText.color = FlxColor.YELLOW;
				}
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

			if(controls.LEFT_P){
				switch(textMenuItems[curSelected]){
					case 'Scroll Speed':
						updateDesc('Scroll Speed: ' + Options.scrollSpeed);
						Options.scrollSpeed-=0.1;
					case 'Offset':
						updateDesc('Offset: ' + Options.offset);
						Options.offset-=1;
				}
			}
			if(controls.RIGHT_P){
				switch(textMenuItems[curSelected]){
					case 'Scroll Speed':
						updateDesc(('Scroll Speed: ' + Options.scrollSpeed));
						Options.scrollSpeed+=0.1;
					case 'Offset':
						updateDesc('Offset: ' + Options.offset);
						Options.offset+=1;
				}
			}

			if(controls.LEFT_P || controls.RIGHT_P)
				FlxG.sound.play(Paths.sound('scrollMenu'));			

			if(controls.BACK){
				trace('Back to the main menu ugu');
				FlxG.switchState(new MainMenuState());
				save();
			}

			if (controls.ACCEPT)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				switch (textMenuItems[curSelected])
				{
					case "Controls":
						switchSubState(new KeyBindMenu());
					case "Middle Scroll":
						Options.middleScroll = !Options.middleScroll;
						updateDesc('Middle Scroll: ' + Options.middleScroll);
					case "Show FPS Counter":
						Options.middleScroll = !Options.middleScroll;
						updateDesc('Show FPS Counter : ' + Std.string(Options.fpsCounter?'Yes':'No'));
				}
			}
		}

		function switchSubState(subState:FlxSubState){
			grpOptionsTexts.forEach(function(txt:FlxText)
			{
				FlxTween.tween(txt,{alpha: 0.7});
			});

			new FlxTimer().start(0.7,function (tmr:FlxTimer){
				FlxG.state.closeSubState();
	            FlxG.state.openSubState(subState);
            	trace('Changing to ' + subState);
			});
		}

		function updateDesc(desc:String){
			descText.text = desc;
			trace('Description Updated To: ' + descText.text);
		}

		function cum(huh:Int){
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
				case "Middle Scroll":
					updateDesc('Middle Scroll: ' + Options.middleScroll);
				case 'Scroll Speed':
					updateDesc('Scroll Speed: ' + Options.scrollSpeed);
				case 'Offset':
					updateDesc('Offset: ' + Options.offset);
				case 'Show FPS Counter':
					updateDesc('Show FPS Counter : ' + Std.string(Options.fpsCounter?'Yes':'No'));
			}

			grpOptionsTexts.forEach(function(txt:FlxText)
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
