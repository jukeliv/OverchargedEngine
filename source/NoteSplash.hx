package;

import flixel.FlxG;
import flixel.FlxSprite;

//Code inspired by PsychEngine Code
class NoteSplash extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0, ?skin:String = 'noteSplashes') {
		super(x, y);
		setupNoteSplash(x, y, note,skin);

		loadAnimations(skin);

		antialiasing = Options.antialiasing;
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, skin:String) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
		alpha = 0.6;
		animation.play('note' + note + '-' + FlxG.random.int(1, 2), true);
		animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
		updateHitbox();
		offset.set(Std.int(0.3 * width), Std.int(0.3 * height));
	}

	public function loadAnimations(path:String){
		frames = Paths.getSparrowAtlas(path);
		for (i in 1...3) {
			animation.addByPrefix("splash1-" + 1, "splash blue" + i, 24, false);
			animation.addByPrefix("splash2-" + 1, "splash green" + i, 24, false);
			animation.addByPrefix("splash0-" + 1, "splash purple" + i, 24, false);
			animation.addByPrefix("splash3-" + 1, "splash red" + i, 24, false);
		}
	}

	override public function update(elapsed)
	{
		if (animation.curAnim.finished)
			kill();
		super.update(elapsed);
	}
}