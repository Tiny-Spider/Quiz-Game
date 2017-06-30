package screens;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.events.MouseEvent;
import openfl.system.System;
import screens.Screen;
import screens.ScreenGame;
import screens.ScreenLeaderboard;

/**
 * Menu screen holds three buttons
 * @author Mark
 */
class ScreenMenu extends Screen
{
	private var titleField:TextField = new TextField();

	// Buttons
	private var buttonStart:Button = new Button("Play", "img/button.png", "img/button_hover.png", Constants.menuButtonWidth, Constants.menuButtonHeight);
	private var buttonLeaderboard:Button = new Button("Leaderboard", "img/button.png", "img/button_hover.png", Constants.menuButtonWidth, Constants.menuButtonHeight);
	private var buttonExit:Button = new Button("Exit", "img/button.png", "img/button_hover.png", Constants.menuButtonWidth, Constants.menuButtonHeight);

	public function new()
	{
		super();

		// Set correct events for the buttons
		buttonStart.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) { Main.getInstance().switchScreen(new ScreenGame()); });
		buttonLeaderboard.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) { Main.getInstance().switchScreen(new ScreenLeaderboard()); });
		buttonExit.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) { System.exit(0); });

		addChild(buttonStart);
		addChild(buttonLeaderboard);
		addChild(buttonExit);

		// Title Field
		titleField.text = "Jungle Adventure";
		titleField.defaultTextFormat = new TextFormat("_sans", 40, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);

		addChild(titleField);
	}

	public override function draw()
	{
		// Title Field
		titleField.height = Constants.menuButtonHeight;
		titleField.width = Constants.menuButtonWidth;

		titleField.y = -((Constants.menuButtonHeight * 3.0) + Constants.menuButtonOffsetY);
		titleField.x = -(Constants.menuButtonWidth / 2.0);

		// Buttons
		buttonStart.y = -(Constants.menuButtonHeight + Constants.menuButtonOffsetY);
		buttonLeaderboard.y = 0;
		buttonExit.y = Constants.menuButtonHeight + Constants.menuButtonOffsetY;
	}

}