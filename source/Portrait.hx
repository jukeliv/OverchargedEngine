package;

import flixel.FlxSprite;

class Portrait extends FlxSprite
{
	/**
	 * Used for DialogueBox! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf')
	{
		super();
		loadGraphic(Paths.image('portraitGrid'), true, 360, 450);

		antialiasing = true;
		animation.add('bf', [0], 0, false,true);
		animation.add('gf', [1], 0, false);
		animation.add('dad', [2], 0, false);
		animation.add('bf-pixel', [3], 0, false,true);
		animation.add('senpai', [4], 0, false);
		animation.add('senpai-angry', [5], 0, false);
		animation.add('spirit', [6], 0, false);
		animation.play(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
