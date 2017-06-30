package;

import openfl.Lib;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.utils.Assets;
import screens.Screen;
import screens.ScreenMenu;

/**
 * Main class of the game, manages everything
 * @author Mark
 */
class Main extends Sprite
{
	// General
	public static var stageWidth:Int;
	public static var stageHeight:Int;

	private static var instance:Main;

	private var screen:Screen;

	private var background:BitmapData = Assets.getBitmapData("img/background.png");

	public function new()
	{
		super();

		instance = this;

		// Initalize static values
		onResize(null);
		Lib.current.stage.addEventListener(Event.RESIZE, onResize);

		// Switch to menu as a start screen
		switchScreen(new ScreenMenu());
	}

	public function switchScreen(newScreen:Screen)
	{
		removeChildren();

		screen = newScreen;
		addChild(screen);
	}

	private function onResize(event:Event)
	{
		// Update the static varibles
		stageWidth = Lib.current.stage.stageWidth;
		stageHeight = Lib.current.stage.stageHeight;

		drawBackground();

		// If there is an active screen call the onResize event
		if (screen != null) screen.onResize();
	}

	private function drawBackground()
	{
		// Simple graphics fill so it covers entire background
		graphics.clear();
		graphics.beginBitmapFill(background, null, true, true);
		graphics.drawRect(0, 0, stageWidth, stageHeight);
		graphics.endFill();
	}

	public static function getInstance():Main
	{
		return instance;
	}
}
