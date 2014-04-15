part of robotlegs;

abstract class LogLevel {
	
	static const int FATAL = 2;

	static const int ERROR = 4;

	static const int WARN = 8;

	static const int INFO = 16;

	static const int DEBUG = 32;

	static const List<dynamic> NAME = const [
		0, 0, 'FATAL', // 2
		0, 'ERROR', // 4
		0, 0, 0, 'WARN', // 8
		0, 0, 0, 0, 0, 0, 0, 'INFO', // 16
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0, 0, 0 , 'DEBUG']; //32
}