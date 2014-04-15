part of robotlegs;

abstract class ILogger {
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void debug(dynamic message, [List<dynamic> params = null]);

	void info(dynamic message, [List<dynamic> params = null]);

	void warn(dynamic message, [List<dynamic> params = null]);

	void error(dynamic message, [List<dynamic> params = null]);

	void fatal(dynamic message, [List<dynamic> params = null]);
}