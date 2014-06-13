part of robotlegs;

class LogManager implements ILogTarget
{
	
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	int _logLevel = LogLevel.INFO;
	int get logLevel => _logLevel;
	set logLevel(int value) => _logLevel = value;
	
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final List<ILogTarget> _targets = new List<ILogTarget>();
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	ILogger getLogger(dynamic source) => new Logger(source, this);

	void addLogTarget(ILogTarget target) => _targets.add(target);
	
	void log(
		dynamic source, 
		int level, 
		int timestamp, 
		String message, 
		[List<dynamic> params = null])
	{
		if(level > _logLevel)
			return;
		
		print( source.toString() + ' ' + level.toString() + ' ' + timestamp.toString() + ' ' + message);
		
		
		_targets.forEach( (ILogTarget target)
		{
			target.log(source, level, timestamp, message);
		});
	}
}