package;

import flixel.FlxG;

class Options
{
	//Preferences Menu Variables
	public static var scrollSpeed:Float = 1;
	public static var antialiasing:Bool = true;

	//Optimization Stuff
	public static var optimType:Int = 0;
	public static var hasBg:Bool = true;
	public static var hasDad:Bool = true;
	public static var globalAntialias:Bool;

	static public function save(){
		FlxG.save.data.scrollSpeed = scrollSpeed;
		FlxG.save.data.antialiasing = antialiasing;
	}
}
