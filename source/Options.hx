package;

import js.html.Option;
import flixel.text.FlxText;
import flixel.FlxG;

class Options
{
	public var description:String;
	public var left = function():Bool {
		if(FlxG.keys.justPressed.LEFT)
			return true;
		else
			return false;
	}
	public var right = function():Bool {
		if(FlxG.keys.justPressed.RIGHT)
			return true;
		else
			return false;
	}
}

class DownScroll extends Option{
	public function new(desc:String){
		super();
	}
	function updateGraphic():String{
		return FlxG.save.data.downScroll ? 'Downscroll: On' :	 'Downscroll: Off';
	}
}	
