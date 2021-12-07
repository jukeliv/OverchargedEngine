package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

//Code and sprites maded by PsychEngine Team
//Edited by OverchargedDev

class NoteSplash extends FlxSprite
{
	private var idleAnim:String;
	private var textureLoaded:String = null;

	public function new(x:Float = 0, y:Float = 0, ?skin:String, ?note:Int = 0) {
		super(x, y);

		if(skin == null)skin = 'noteSplashes';

		loadAnims(skin);

		setupNoteSplash(x, y, note, skin);
		antialiasing = Options.antialiasing;
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, texture:String = null) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
		alpha = 0.6;

		if(texture == null) {
			texture = 'noteSplashes';
		}

		if(textureLoaded != texture) {
			loadAnims(texture);
		}
		offset.set(10, 10);

		var animNum:Int = FlxG.random.int(1, 2);
		animation.play('splash' + note + '-' + animNum, true);
	}

	function loadAnims(path:String) {
		frames = Paths.getSparrowAtlas(path);
		for (i in 1...3) {
			var framerate:Int = FlxG.random.int(16,24);
			animation.addByPrefix("splash1-" + i, "splash blue " + i, framerate, false);
			animation.addByPrefix("splash2-" + i, "splash green " + i, framerate, false);
			animation.addByPrefix("splash0-" + i, "splash purple " + i, framerate, false);
			animation.addByPrefix("splash3-" + i, "splash red " + i, framerate, false);
		}
	}

	override function update(elapsed:Float) {
		if(animation.curAnim.finished)
			kill();
		super.update(elapsed);
	}
}