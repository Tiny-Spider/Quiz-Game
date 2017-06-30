package screens;

import openfl.events.MouseEvent;
import screens.Screen;

import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * Game screen that manages
 * @author Mark
 */
class ScreenGame extends Screen
{
	private var scene:Scene;

	// Name Input
	private var nameInputTitle:TextField = new TextField();
	private var nameInput:TextField = new TextField();
	private var nameButton:Button = new Button("Enter", "img/button.png", "img/button_hover.png", Constants.gameInputButtonWidth, Constants.gameInputButtonHeight);

	// Win/Lose Items
	private var titleField:TextField = new TextField();
	private var descriptionField:TextField = new TextField();
	private var menuButton:Button = new Button("Main Menu", "img/button.png", "img/button_hover.png", Constants.optionWidth, Constants.optionHeight);

	// User Info
	private var username:String = "";
	private var score:Int = 0;

	public function new()
	{
		super();

		// Name Input
		nameInput.selectable = true;
		nameInput.type = TextFieldType.INPUT;
		nameInput.border = true;
		nameInput.borderColor = 0xFFFFFF;
		nameInput.defaultTextFormat = new TextFormat("_sans", 15, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);

		// Name Input Title
		nameInputTitle.text = "Please enter your name:";
		nameInputTitle.defaultTextFormat = new TextFormat("_sans", 15, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);

		// Name Input Button
		nameButton.addEventListener(MouseEvent.CLICK, submitName);

		// Menu Button
		menuButton.addEventListener(MouseEvent.CLICK, submitAndExit);

		// Title Field
		titleField.defaultTextFormat = new TextFormat("_sans", 40, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
		titleField.wordWrap = true;
		titleField.selectable = false;

		// Description Field
		descriptionField.defaultTextFormat = new TextFormat("_sans", 15, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
		descriptionField.wordWrap = true;
		descriptionField.selectable = false;

		addChild(nameInputTitle);
		addChild(nameInput);
		addChild(nameButton);
	}

	// Sumbit username
	private function submitName(e:MouseEvent)
	{
		var input:String = nameInput.text;

		// If input is empty don't start the game
		if (input == null || StringTools.trim(input) == "")
		{
			return;
		}

		username = input;
		switchScene(1);
	}

	// Add score to highscores and switch to menu screen
	private function submitAndExit(e:MouseEvent)
	{
		Database.addHighscore(username, score);
		Main.getInstance().switchScreen(new ScreenMenu());
	}

	public function addScore(score:Int)
	{
		this.score += score;
	}

	// Switch the current scene to a new scene
	public function switchScene(sceneId:Int)
	{
		removeChildren();

		scene = new Scene(sceneId, this);
		addChild(scene);
	}

	// Win the game
	public function winGame()
	{
		removeChildren();

		titleField.text = "You Win!";
		descriptionField.text = 'You got a score of: $score';

		addChild(titleField);
		addChild(descriptionField);
		addChild(menuButton);
	}

	// Lose the game
	public function loseGame()
	{
		removeChildren();

		titleField.text = "You Died!";
		descriptionField.text = 'You got a score of: $score';

		addChild(titleField);
		addChild(descriptionField);
		addChild(menuButton);
	}

	public override function draw()
	{
		// Name Button
		nameButton.x = ((Constants.gameInputWidth / 2.0) + Constants.gameInputOffset + (Constants.gameInputButtonWidth / 2.0));
		nameButton.y = Constants.gameInputButtonHeight / 2.0;

		// Name Input
		nameInput.width = Constants.gameInputWidth;
		nameInput.height = Constants.gameInputHeight;
		nameInput.x = -(Constants.gameInputWidth / 2.0);

		// Name Input Title
		nameInputTitle.height = Constants.gameInputTitleHeight;
		nameInputTitle.width = Constants.gameInputTitleWidth;
		nameInputTitle.x = -(Constants.gameInputWidth / 2.0);
		nameInputTitle.y = -(Constants.gameInputHeight);

		// Title Field
		titleField.height = Constants.sceneTitleHeight;
		titleField.width = Constants.sceneTitleWidth;
		titleField.x = -(Constants.sceneTitleWidth / 2.0);
		titleField.y = -(Constants.sceneTitleOffsetY + Constants.sceneTitleHeight +  Constants.sceneDescriptionHeight);

		// Description Field
		descriptionField.height = Constants.sceneDescriptionHeight;
		descriptionField.width = Constants.sceneDescriptionWidth;
		descriptionField.x = -(Constants.sceneDescriptionWidth / 2.0);
		descriptionField.y = -(Constants.sceneDescriptionHeight);

		// Menu Button
		menuButton.y = Constants.menuButtonHeight / 2.0;

		// Draw the scene if it exists
		if (scene != null) scene.draw();
	}

}