part of robotlegs;

class PrintLogTarget implements ILogTarget
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	LogMessageParser _messageParser = new LogMessageParser();
	
	IContext _context;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	PrintLogTarget(this._context);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void log(dynamic source, int level, DateTime timestamp, String message, [List<dynamic> params = null])
	{
		print(timestamp.toString()
				+ ' ' + LogLevel.NAME[level].toString()
				+ ' ' + _context.runtimeType.toString()
				+ ' ' + source.runtimeType.toString()
				+ ' ' + _messageParser.parseMessage(message, params));
	}
}