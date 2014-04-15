part of robotlegs;

abstract class LifecycleState {
	
	static const String UNINITIALIZED = "uninitialized";

	static const String INITIALIZING = "initializing";

	static const String ACTIVE = "active";

	static const String SUSPENDING = "suspending";

	static const String SUSPENDED = "suspended";

	static const String RESUMING = "uninitialized";

	static const String DESTROYING = "destroying";

	static const String DESTROYED = "destroyed";
}