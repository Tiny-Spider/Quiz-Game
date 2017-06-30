package options;

import openfl.display.Sprite;

/**
 * Holder for all option related data
 * @author Mark
 */
class Option
{
	// Varibles
	public var text:String;
	public var sceneId:Int;
	public var score:Int;

	public function new(text:String, sceneId:Int, score:Int)
	{
		this.text = text;
		this.sceneId = sceneId;
		this.score = score;
	}
}