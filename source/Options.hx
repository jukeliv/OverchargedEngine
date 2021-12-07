package;

import flixel.FlxG;

class Options
{
	//Preferences Menu Variables
	public static var scrollSpeed:Float = 1;
	public static var antialiasing:Bool = true;
	public static var fpsCap:Bool = true;
	public static var optimization:Bool = false;
	public static var framerate:Int = 60;
	public static var ghostTap:Bool = true;

	//to much cloned stuff xD, if you dont like it
	//fuk you and re-do the system IDIOT!!
	static public function save(){
		FlxG.save.data.scrollSpeed = scrollSpeed;
		FlxG.save.data.antialiasing = antialiasing;
		FlxG.save.data.fpsCap = fpsCap;
		FlxG.save.data.optimization = optimization;
		FlxG.save.data.framerate = framerate;
		FlxG.save.data.ghostTap = ghostTap;
	}
	static public function load(){
		if(FlxG.save.data.scrollSpeed != null)
		scrollSpeed = FlxG.save.data.scrollSpeed;
		if(FlxG.save.data.antialiasing != null)
			antialiasing = FlxG.save.data.antialiasing;
		if(FlxG.save.data.fpsCap != null)
			fpsCap = FlxG.save.data.fpsCap;
		if(FlxG.save.data.optimization != null)
			optimization = FlxG.save.data.optimization;
		if(FlxG.save.data.framerate != null)
			framerate = FlxG.save.data.framerate;
		if(FlxG.save.data.ghostTap != null)
			ghostTap = FlxG.save.data.ghostTap;
	}
}
