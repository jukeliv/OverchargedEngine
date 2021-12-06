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

		if(skin == null && PlayState.daSkin == null)skin = 'default_noteSplash';
		else skin = PlayState.daSkin.noteSplash_path;

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
		animation.play('splash' + note + '-' + animNum, true);
		animation.curAnim.frameRate = 24 + FlxG.random.int(-2, 2);
	}

	function loadAnims(path:String) {
		frames = Paths.getSparrowAtlas(path,'skins');
		for (i in 1...3) {
			animation.addByPrefix("splash1-" + i, "splash blue " + i, 16, false);
			animation.addByPrefix("splash2-" + i, "splash green " + i, 16, false);
			animation.addByPrefix("splash0-" + i, "splash purple " + i, 16, false);
			animation.addByPrefix("splash3-" + i, "splash red " + i, 16, false);
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