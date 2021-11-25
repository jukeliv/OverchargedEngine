package;

import haxe.Json;
import lime.utils.Assets;

using StringTools;

typedef SwagModChart = {
    var modChart:String;
    var steps:Array<Int>;
    var events:Array<String>;
    var values:Array<String>;
}

class CustomChart {
    public var modChart:String;
    public var steps:Array<Int>;
    public var events:Array<String>;
    public var values:Array<String>;

    public function new(modChart,steps,events,values) {
        this.modChart = modChart;
        this.steps = steps;
        this.events = events;
        this.values = values;
    }

    public static function loadFromJson():SwagModChart
    {
        var rawJson = Assets.getText(Std.string('assets/data/custom/'+ PlayState.SONG.song.toLowerCase() + '/mod.json')).trim();
    
        while (!rawJson.endsWith("}"))
        {
            rawJson = rawJson.substr(0, rawJson.length - 1);
            // LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
        }

        return parseMod(rawJson);
    }

    public static function parseMod(rawData:String):SwagModChart
    {
        var swagShit:SwagModChart = cast Json.parse(rawData).modChart;
        return swagShit;
    }
}   