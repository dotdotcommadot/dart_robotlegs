part of robotlegs;

class Logger implements ILogger
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	dynamic _source;
	
	ILogTarget _target;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	Logger(this._source, this._target);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void debug(dynamic message, [List<dynamic> params = null])
	{
		_target.log(_source, 32, new DateTime.now().millisecondsSinceEpoch, message, params);
	}

	void info(dynamic message, [List<dynamic> params = null])
	{
		_target.log(_source, 16, new DateTime.now().millisecondsSinceEpoch, message, params);
	}

	void warn(dynamic message, [List<dynamic> params = null])
	{
		_target.log(_source, 8, new DateTime.now().millisecondsSinceEpoch, message, params);
	}
	
	void error(dynamic message, [List<dynamic> params = null])
	{
		_target.log(_source, 4, new DateTime.now().millisecondsSinceEpoch, message, params);
	}

	void fatal(dynamic message, [List<dynamic> params = null])
	{
		_target.log(_source, 8, new DateTime.now().millisecondsSinceEpoch, message, params);
	}
}