package;

import haxe.Json;
import lime.utils.Assets;

using StringTools;

typedef Skin =
{
	var skin_path:String;
	var noteSplash_path:String;
	var hit_sounds:Array<String>;
}

class NoteSkin
{
	public var skin_path:String;
	public var noteSplash_path:String;
	public var hit_sounds:Array<String>;

	public static function loadFromJson(skin:String):Skin
	{
        var skinLowered:String = skin.toLowerCase();
		var rawJson = Assets.getText('assets/note_skins/$skinLowered.json').trim();

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
			// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
		}

		return parseJSONshit(rawJson);
	}

	public static function parseJSONshit(rawJson:String):Skin
	{
		var dumSkin:Skin = cast Json.parse(rawJson).skin;
		return dumSkin;
	}
}