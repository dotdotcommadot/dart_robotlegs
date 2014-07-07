part of robotlegs;

class LifecycleMessage
{
	static const Symbol ERROR = const Symbol("LifecycleMessage.error");

	static const Symbol STATE_CHANGE = const Symbol("LifecycleMessage.stateChange");

	static const Symbol PRE_INITIALIZE = const Symbol("LifecycleMessage.preInitialize");
	
	static const Symbol INITIALIZE = const Symbol("LifecycleMessage.initialize");

	static const Symbol POST_INITIALIZE = const Symbol("LifecycleMessage.postInitialize");

	static const Symbol PRE_SUSPEND = const Symbol("LifecycleMessage.preSuspend");

	static const Symbol SUSPEND = const Symbol("LifecycleMessage.suspend");

	static const Symbol POST_SUSPEND = const Symbol("LifecycleMessage.postSuspend");
	
	static const Symbol PRE_RESUME = const Symbol("LifecycleMessage.preResume");

	static const Symbol RESUME = const Symbol("LifecycleMessage.resume");

	static const Symbol POST_RESUME = const Symbol("LifecycleMessage.postResume");

	static const Symbol PRE_DESTROY = const Symbol("LifecycleMessage.preDestroy");

	static const Symbol DESTROY = const Symbol("LifecycleMessage.destroy");

	static const Symbol POST_DESTROY = const Symbol("LifecycleMessage.postDestroy");
}