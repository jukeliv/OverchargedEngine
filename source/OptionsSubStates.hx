package;

import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;

class OptionsSubStates extends MusicBeatSubstate
{
    //Here you add some gloval functions, than are used in most of the Options Menus
    var descText:FlxText;
    var spr_UI:FlxTypedGroup<FlxSprite>;
    override function create() {
        //here you add some UI or init some global variables
        descText = new FlxText();
		descText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER);
		descText.screenCenter();
		descText.y += 320;
		descText.x -= 120;
		add(descText);

        super.create();
    }
    public function changeState(state:FlxSubState){
        spr_UI.forEach(function(spr:FlxSprite){
            FlxTween.tween(spr,{alpha:0},0.45,{onComplete: function(twn:FlxTween){
            }});
        });
        
        FlxTween.tween(descText,{alpha:0},0.45,{onComplete: function(twn:FlxTween){
        }});

        new FlxTimer().start(0.45,function(tmr:FlxTimer){
            FlxG.state.closeSubState();
            FlxG.state.openSubState(state);
            trace('goto  ' + state);
        });
    }

    function updateDesc(desc:String){
        descText.text = desc;
        FlxG.sound.play(Paths.sound('scrollMenu'));
        trace('Description Updated To: ' + descText.text);
    }
}

class OptimizationMenu extends OptionsSubStates{
    var textMenuItems:Array<String> = ['Optimization  Type','Have BackGround','Have Dad','Back'];
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	public function new()
		{
		super();

		//load values
		if(FlxG.save.data.optimType != null)
			Options.optimType = FlxG.save.data.optimType;
		if(FlxG.save.data.hasBg != null)
			Options.hasBg = FlxG.save.data.hasBg;
		if(FlxG.save.data.hasDad != null)
			Options.hasDad = FlxG.save.data.hasDad;

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

    var optimText:String;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        switch(Options.optimType){
            case 0:
                optimText = 'None';
            case 1:
                optimText = 'Potato';
            case 2:
                optimText = 'Android 3.1';
        }

		if (controls.UP_P)
			cum(-1);

		if (controls.DOWN_P)
			cum(1);

		if(controls.LEFT_P){
			switch(textMenuItems[curSelected]){
				case 'Optimization  Type':
					updateDesc('Optimization Type: ' + optimText);

                    if(Options.optimType > 0)
                        Options.scrollSpeed-=1;
			}
		}
		if(controls.RIGHT_P){
			switch(textMenuItems[curSelected]){
			    case 'Optimization  Type':
					updateDesc('Optimization Type: ' + optimText);

                    if(Options.optimType < 3)
                        Options.scrollSpeed+=1;
			}
		}

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
				FlxTween.tween(txt,{alpha: 0});
			});
			changeState(subState);
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

class PlayVariablesMenu extends OptionsSubStates{
    var textMenuItems:Array<String> = ['Middle Scroll','Scroll Speed','Offset','Show FPS Counter'];
	var curSelected:Int = 0;

	public static var acceptInput:Bool;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;

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
				FlxTween.tween(txt,{alpha: 0});
			});
			changeState(subState);
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