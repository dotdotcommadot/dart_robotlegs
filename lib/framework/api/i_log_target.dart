part of robotlegs;

abstract class ILogTarget {
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void log(dynamic source, int level, DateTime timestamp, String message, [List<dynamic> params = null]);
}