package;

import motion.Actuate;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import options.Option;
import options.OptionManager;
import screens.ScreenGame;
import sys.db.ResultSet;

/**
 * A scene class, it is directly bound to a scene from the database
 * Contains the options too
 * @author Mark
 */
class Scene extends Sprite
{
	// Data from database
	public var title:String = "None";
	public var description:String = "-";
	public var time:Int = -1;
	public var timeSceneId:Int = 1;
	public var image:String = "";
	public var options:Array<Int> = new Array<Int>();

	// Private display values
	private var timeRemaining:Int = 10;
	private var imageBitmap:Bitmap;
	private var titleField:TextField = new TextField();
	private var descriptionField:TextField = new TextField();

	private var game:ScreenGame;
	private var active:Bool = true;

	public function new(sceneId:Int, game:ScreenGame)
	{
		super();

		this.game = game;

		// Load scene data and select first result
		var result:ResultSet = Database.getSceneData(sceneId);
		var data:Null<Dynamic> = result.results().first();

		if (data.title != null) 		title = data.title;
		if (data.description != null) 	description = data.description;
		if (data.time != null) 			time = data.time;
		if (data.time_scene_id != null)	timeSceneId = data.time_scene_id;
		if (data.image != null) 		image = data.image;

		if (data.option_1 != null) options.push(data.option_1);
		if (data.option_2 != null) options.push(data.option_2);
		if (data.option_3 != null) options.push(data.option_3);
		if (data.option_4 != null) options.push(data.option_4);

		create();
		draw();
	}

	// Create the fields and images
	private function create()
	{
		// Text Field
		titleField.text = title;
		titleField.defaultTextFormat = new TextFormat("_sans", 40, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
		titleField.wordWrap = true;
		titleField.selectable = false;

		// Description Field
		descriptionField.text = description;
		descriptionField.defaultTextFormat = new TextFormat("_sans", 15, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
		descriptionField.wordWrap = true;
		descriptionField.selectable = false;

		// Try load image
		if (Assets.exists("img/" + image))
		{
			imageBitmap = new Bitmap(Assets.getBitmapData("img/" + image));
		}

		// If time is a thing then start the countdown
		if (time > 0)
		{
			timeRemaining = time;
			countDown();
		}
	}

	// Count down for timed events
	private function countDown()
	{
		if (!active) return;
		
		if (timeRemaining > 0)
		{
			titleField.text = '$title ($timeRemaining)';
			
			// Simple function recursion
			Actuate.timer(1.0).onComplete(countDown);
		}
		else
		{
			game.switchScene(timeSceneId);
			return;
		}

		timeRemaining--;
	}

	public function draw()
	{
		removeChildren();

		// Name Field (Title)
		titleField.height = Constants.sceneTitleHeight;
		titleField.width = Constants.sceneTitleWidth;
		titleField.x = -(Constants.sceneTitleWidth / 2.0);
		titleField.y = -(Constants.sceneTitleOffsetY + Constants.sceneTitleHeight +  Constants.sceneDescriptionHeight + Constants.sceneDescriptionOffsetY);

		addChild(titleField);

		// Description Field
		descriptionField.height = Constants.sceneDescriptionHeight;
		descriptionField.width = Constants.sceneDescriptionWidth;
		descriptionField.x = -(Constants.sceneDescriptionWidth / 2.0);
		descriptionField.y = -(Constants.sceneDescriptionOffsetY + Constants.sceneDescriptionHeight);

		addChild(descriptionField);

		// Image
		if (imageBitmap != null)
		{
			imageBitmap.height = Constants.sceneImageHeight;
			imageBitmap.width = Constants.sceneImageWidth;

			imageBitmap.x = -(Constants.sceneImageWidth / 2.0);
			imageBitmap.y = -(Constants.sceneImageHeight);

			addChild(imageBitmap);
		}

		// Option buttons
		for (i in 0...options.length)
		{
			var optionId:Int = options[i];
			var button:Button = new Button("text", "img/button.png", "img/button_hover.png", Constants.optionWidth, Constants.optionHeight);

			button.y = Constants.optionOffsetY + (Constants.optionHeight / 2.0) + ((Constants.optionHeight + Constants.optionOffsetY) * i);

			// Win the game
			if (optionId == -1)
			{
				button.setText("Win");
				button.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) { active = false; game.winGame(); });
			}
			// Lose the game
			else if (optionId == -2)
			{
				button.setText("Die");
				button.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) { active = false; game.loseGame(); });
			}
			// Normal option
			else
			{
				var option:Option = OptionManager.getOption(optionId);
				
				button.setText(option.text);
				button.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {	active = false; game.addScore(option.score); game.switchScene(option.sceneId); });
			}
			
			addChild(button);
		}
	}

}