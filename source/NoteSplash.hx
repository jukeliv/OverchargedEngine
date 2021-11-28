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
		antialiasing = Options.globalAntialias;
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
		animation.play('note' + note + '-' + animNum, true);
		animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
	}

	function loadAnims(path:String) {
		frames = Paths.getSparrowAtlas(path);
		for (i in 1...3) {
			animation.addByPrefix("note1-" + i, "note splash blue " + i, 16, false);
			animation.addByPrefix("note2-" + i, "note splash green " + i, 16, false);
			animation.addByPrefix("note0-" + i, "note splash purple " + i, 16, false);
			animation.addByPrefix("note3-" + i, "note splash red " + i, 16, false);
		}
	}

	override function update(elapsed:Float) {
		if(animation.curAnim.finished){
			kill();
			trace(this + ' elemenated');
		}
		super.update(elapsed);
	}
}