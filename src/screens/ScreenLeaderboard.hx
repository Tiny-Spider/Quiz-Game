package screens;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import screens.Screen;

import openfl.events.MouseEvent;

/**
 * A screen that displays the leaderboard/highscores
 * @author Mark
 */
class ScreenLeaderboard extends Screen
{
	// Buttons
	private var buttonMenu:Button = new Button("Menu", "img/button.png", "img/button_hover.png", Constants.leaderboardButtonWidth, Constants.leaderboardButtonHeight);
	private var buttonClear:Button = new Button("Clear", "img/button.png", "img/button_hover.png", Constants.leaderboardButtonWidth, Constants.leaderboardButtonHeight);

	private var scores:TextField = new TextField();

	public function new()
	{
		super();

		// Add events to the buttons
		buttonMenu.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) { Main.getInstance().switchScreen(new ScreenMenu()); });
		buttonClear.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) { Database.clearHighscores(); loadScores(); });

		scores.defaultTextFormat = new TextFormat("_sans", 20, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);

		loadScores();

		addChild(buttonMenu);
		addChild(buttonClear);
		addChild(scores);
	}

	// Loads and displays the scores (max 15 entries)
	public function loadScores()
	{
		var datas = Database.getHighscores(15);
		var text:String = "";
		var place = 0;

		for (data in datas)
		{
			place++;

			var username:String = data.username;
			var score:Int = data.score;

			text += '$place. $username ($score) \n';
		}

		scores.text = text;
	}

	public override function draw()
	{
		// Menu Button
		buttonMenu.x = -((Main.stageWidth / 2.0) - (Constants.leaderboardButtonWidth / 2.0) - Constants.leaderboardButtonOffset);
		buttonMenu.y = ((Main.stageHeight / 2.0) - (Constants.leaderboardButtonHeight / 2.0) - Constants.leaderboardButtonOffset);

		// Clear Button
		buttonClear.x = (Main.stageWidth / 2.0) - (Constants.leaderboardButtonWidth / 2.0) - Constants.leaderboardButtonOffset;
		buttonClear.y = (Main.stageHeight / 2.0) - (Constants.leaderboardButtonHeight / 2.0) - Constants.leaderboardButtonOffset;

		// Scores
		scores.x = -(Main.stageWidth / 4.0);
		scores.y = -(Main.stageHeight / 4.0);

		scores.width = Main.stageWidth / 2.0;
		scores.height = Main.stageHeight / 2.0;
	}
}