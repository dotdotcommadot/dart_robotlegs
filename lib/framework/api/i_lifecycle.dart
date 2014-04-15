part of robotlegs;

abstract class ILifecycle {
	
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	String get state;

	dynamic get target;

	bool get uninitialized;

	bool get initialized;

	bool get active;

	bool get suspended;

	bool get destroyed;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void initialize([Function callback = null]);

	void suspend([Function callback = null]);

	void resume([Function callback = null]);

	void destroy([Function callback = null]);
	
	ILifecycle beforeInitializing(Function handler);

	ILifecycle whenInitializing(Function handler);

	ILifecycle afterInitializing(Function handler);

	ILifecycle beforeSuspending(Function handler);

	ILifecycle whenSuspending(Function handler);

	ILifecycle afterSuspending(Function handler);

	ILifecycle beforeResuming(Function handler);

	ILifecycle whenResuming(Function handler);

	ILifecycle afterResuming(Function handler);

	ILifecycle beforeDestroying(Function handler);

	ILifecycle whenDestroying(Function handler);

	ILifecycle afterDestroying(Function handler);
}