part of robotlegs;

abstract class ILogTarget {
	
	void log(dynamic source, int level, int timestamp, String message, [List<dynamic> params = null]);
}