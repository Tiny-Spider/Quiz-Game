package;

import sys.db.Connection;
import sys.db.ResultSet;
import sys.db.Sqlite;

/**
 * ...
 * @author Mark
 */
class Database
{
	private static var database:Connection;

	// Lazy initialization of the database
	public static function getInstance():Connection
	{
		if (database == null)
		{
			database = Sqlite.open('data/database.db');
		}
		return database;
	}

	public static function getSceneData(sceneId:Int):ResultSet
	{
		return getInstance().request('SELECT * FROM scenes WHERE scene_id=$sceneId');
	}

	public static function getOptions():ResultSet
	{
		return getInstance().request("SELECT * FROM options");
	}

	public static function addHighscore(username:String, score:Int):ResultSet
	{
		return getInstance().request('INSERT INTO scores ("username", "score") VALUES ("$username", $score)');
	}

	public static function getHighscores(amount:Int):ResultSet
	{
		return getInstance().request('SELECT * FROM scores ORDER BY score DESC LIMIT $amount');
	}

	public static function clearHighscores():ResultSet
	{
		return getInstance().request("DELETE FROM scores");
	}
}