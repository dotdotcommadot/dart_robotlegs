part of robotlegs;

abstract class IContext 
{
	IInjector get injector;
	
	int get logLevel;
	
	void set logLevel(int value);
	
	String get state;
	
	bool get uninitialized;
	
	bool get initialized;
	
	bool get active;
	
	bool get suspended;
	
	bool get destroyed;
	
	IContext install(List<Type> extensions);
	
	IContext configure(List configs);
	
	IContext addChild(IContext child);

	IContext removeChild(IContext child);

	IContext addConfigHandler(IMatcher matcher, Function handler);

	ILogger getLogger(dynamic source);

	IContext addLogTarget(ILogTarget target);

	IContext detain(List<dynamic> instances);

	IContext release(List<dynamic> instances);

	void initialize([Function callback = null]);

	void suspend([Function callback = null]);

	void resume([Function callback = null]);

	void destroy([Function callback = null]);
	
	IContext beforeInitializing(Function handler);

	IContext whenInitializing(Function handler);

	IContext afterInitializing(Function handler);

	IContext beforeSuspending(Function handler);
	
	IContext whenSuspending(Function handler);

	IContext afterSuspending(Function handler);

	IContext beforeResuming(Function handler);

	IContext whenResuming(Function handler);

	IContext afterResuming(Function handler);

	IContext beforeDestroying(Function handler);

	IContext whenDestroying(Function handler);

	IContext afterDestroying(Function handler);
}