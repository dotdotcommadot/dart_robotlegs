part of robotlegs;

abstract class ILogTarget {
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void log(dynamic source, int level, int timestamp, String message, [List<dynamic> params = null]);
}