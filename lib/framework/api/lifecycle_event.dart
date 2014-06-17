part of robotlegs;

class LifecycleEvent extends Message{
	
	static const String ERROR = "_error";

	static const String STATE_CHANGE = "stateChange";

	static const String PRE_INITIALIZE = "preInitialize";
	
	static const String INITIALIZE = "initialize";

	static const String POST_INITIALIZE = "postInitialize";

	static const String PRE_SUSPEND = "preSuspend";

	static const String SUSPEND = "suspend";

	static const String POST_SUSPEND = "postSuspend";
	
	static const String PRE_RESUME = "preResume";

	static const String RESUME = "resume";

	static const String POST_RESUME = "postResume";

	static const String PRE_DESTROY = "preDestroy";

	static const String DESTROY = "destroy";

	static const String POST_DESTROY = "postDestroy";
	
	LifecycleEvent(name, target, order, [data = null]) : super(name, target, order, [data = null]);
}