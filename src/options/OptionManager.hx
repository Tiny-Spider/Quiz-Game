package options;

import openfl.utils.Dictionary;
import sys.db.ResultSet;

/**
 * A manager class for all Options
 * @author Mark
 */
class OptionManager
{
	private static var options:Dictionary<Int, Option>;

	// Load and cache options
	private static function initalize()
	{
		options = new Dictionary<Int, Option>();

		var optionsDatas:ResultSet = Database.getOptions();

		// Load all options
		for (optionsData in optionsDatas)
		{
			var optionId:Int = optionsData.option_id;
			var option:Option = new Option(optionsData.text, optionsData.scene_id, optionsData.points);

			options.set(optionId, option);
		}
	}

	public static function getOption(optionId:Int)
	{
		// Lazy initialization
		if (options == null)
		{
			initalize();
		}

		return options.get(optionId);
	}
}