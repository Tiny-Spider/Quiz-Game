package screens;

import openfl.display.Sprite;

/**
 * A base class for screens
 * @author Mark
 */
class Screen extends Sprite
{

	public function new()
	{
		super();

		onResize();
	}

	public function onResize()
	{
		// Recenter this object in the middle of the screen
		x = Main.stageWidth / 2.0;
		y = Main.stageHeight / 2.0;

		// Draw (and reposition) all objects
		draw();
	}

	public function draw()
	{

	}

}