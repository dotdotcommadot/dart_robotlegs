part of robotlegs;

class Lifecycle implements ILifecycle
{
	
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	String _state = LifecycleState.UNINITIALIZED;
	String get state => _state;

	dynamic _target;
	dynamic get target => _target;

	bool get uninitialized => (_state == LifecycleState.UNINITIALIZED);

	bool get initialized => _state != LifecycleState.UNINITIALIZED && _state != LifecycleState.INITIALIZING;

	bool get active => _state == LifecycleState.ACTIVE;

	bool get suspended => _state == LifecycleState.SUSPENDED;

	bool get destroyed => _state == LifecycleState.DESTROYED;
	
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	final Map _reversedEventTypes = new Map();
	
	int _reversePriority;
	
	LifecycleTransition _initialize;

	LifecycleTransition _suspend;

	LifecycleTransition _resume;

	LifecycleTransition _destroy;

	EventDispatcher _dispatcher;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	Lifecycle(this._target)
	{
		if (target != null) 
			_dispatcher = target as EventDispatcher;
		/*else
			_dispatcher = this;*/
		
		_configureTransitions();
	}
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void initialize([Function callback = null])
	{
		_initialize.enter(callback);
	}

	void suspend([Function callback = null])
	{
		_suspend.enter(callback);
	}

	void resume([Function callback = null])
	{
		_resume.enter(callback);
	}

	void destroy([Function callback = null])
	{
		_destroy.enter(callback);
	}
	
	ILifecycle beforeInitializing(Function handler)
	{
		if (!uninitialized)
			_reportError(LifecycleError.LATE_HANDLER_ERROR_MESSAGE);
  	
		_initialize.addBeforeHandler(handler);
  	return this;
	}

	ILifecycle whenInitializing(Function handler)
	{
		if (initialized)
			_reportError(LifecycleError.LATE_HANDLER_ERROR_MESSAGE);
		_dispatcher.addListener(new Symbol(LifecycleEvent.INITIALIZE), createSyncLifecycleListener(handler));
 	 	//TODO: addEventListener(LifecycleEvent.INITIALIZE, createSyncLifecycleListener(handler, true));
  	return this;
	}

	ILifecycle afterInitializing(Function handler)
	{
		if (initialized)
			_reportError(LifecycleError.LATE_HANDLER_ERROR_MESSAGE);
		_dispatcher.addListener(new Symbol(LifecycleEvent.POST_INITIALIZE), createSyncLifecycleListener(handler));
 		//TODO: addEventListener(LifecycleEvent.POST_INITIALIZE, createSyncLifecycleListener(handler, true));
  	return this;
	}

	ILifecycle beforeSuspending(Function handler)
	{
		_suspend.addBeforeHandler(handler);
  	return this;
	}

	ILifecycle whenSuspending(Function handler)
	{
		//TODO: addEventListener(LifecycleEvent.SUSPEND, createSyncLifecycleListener(handler));
		_dispatcher.addListener(new Symbol(LifecycleEvent.SUSPEND), createSyncLifecycleListener(handler));
  	return this;
	}

	ILifecycle afterSuspending(Function handler)
	{
		//TODO: addEventListener(LifecycleEvent.POST_SUSPEND, createSyncLifecycleListener(handler));
		_dispatcher.addListener(new Symbol(LifecycleEvent.POST_SUSPEND), createSyncLifecycleListener(handler));
 		return this;
	}

	ILifecycle beforeResuming(Function handler)
	{
		_resume.addBeforeHandler(handler);
  	return this;
	}

	ILifecycle whenResuming(Function handler)
	{
		//TODO: addEventListener(LifecycleEvent.RESUME, createSyncLifecycleListener(handler));
		_dispatcher.addListener(new Symbol(LifecycleEvent.RESUME), createSyncLifecycleListener(handler));
  	return this;
	}

	ILifecycle afterResuming(Function handler)
	{
		//TODO: addEventListener(LifecycleEvent.POST_RESUME, createSyncLifecycleListener(handler));
		_dispatcher.addListener(new Symbol(LifecycleEvent.POST_RESUME), createSyncLifecycleListener(handler));
  	return this;
	}

	ILifecycle beforeDestroying(Function handler)
	{
		_destroy.addBeforeHandler(handler);
  	return this;
	}

	ILifecycle whenDestroying(Function handler)
	{
		//TODO: addEventListener(LifecycleEvent.DESTROY, createSyncLifecycleListener(handler, true));
		_dispatcher.addListener(new Symbol(LifecycleEvent.DESTROY), createSyncLifecycleListener(handler));
  	return this;
	}

	ILifecycle afterDestroying(Function handler)
	{
		//TODO: addEventListener(LifecycleEvent.POST_DESTROY, createSyncLifecycleListener(handler, true));
		_dispatcher.addListener(new Symbol(LifecycleEvent.POST_DESTROY), createSyncLifecycleListener(handler));
  	return this;
	}
	
	//TODO
	/*void addEventListener()
	{
		priority = flipPriority(type, priority);
	}*/
	
	//TODO
	/*void removeEventListener()
	{
		_dispatcher.removeEventListener(type, listener, useCapture);
	}*/
	
	//TODO
	void dispatchEvent(String type)
	{
		return _dispatcher.send(new Symbol(type));
	}

	//TODO
	bool hasEventListener(String type)
	{
		return _dispatcher.hasListener(new Symbol(type));
	}

	//TODO
	/*bool willTrigger()
	{
		
	}*/
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void setCurrentState(String state)
	{
		if (_state == state)
			return;
		_state = state;
		
		dispatchEvent(LifecycleEvent.STATE_CHANGE);
	}
	
	void _addReversedEventTypes(List types)
	{
		types.forEach((type) {
			_reversedEventTypes[type] = true;
		});
	}
	
	void _configureTransitions()
	{
		_initialize = new LifecycleTransition(LifecycleEvent.PRE_INITIALIZE, this)
  		.fromStates([LifecycleState.UNINITIALIZED])
  		.toStates(LifecycleState.INITIALIZING, LifecycleState.ACTIVE)
  		.withEvents(LifecycleEvent.PRE_INITIALIZE, LifecycleEvent.INITIALIZE, LifecycleEvent.POST_INITIALIZE);

		_suspend = new LifecycleTransition(LifecycleEvent.PRE_SUSPEND, this)
  		.fromStates([LifecycleState.ACTIVE])
  		.toStates(LifecycleState.SUSPENDING, LifecycleState.SUSPENDED)
  		.withEvents(LifecycleEvent.PRE_SUSPEND, LifecycleEvent.SUSPEND, LifecycleEvent.POST_SUSPEND)
  		.inReverse();

		_resume = new LifecycleTransition(LifecycleEvent.PRE_RESUME, this)
  		.fromStates([LifecycleState.SUSPENDED])
  		.toStates(LifecycleState.RESUMING, LifecycleState.ACTIVE)
  		.withEvents(LifecycleEvent.PRE_RESUME, LifecycleEvent.RESUME, LifecycleEvent.POST_RESUME);

		_destroy = new LifecycleTransition(LifecycleEvent.PRE_DESTROY, this)
  		.fromStates([LifecycleState.SUSPENDED, LifecycleState.ACTIVE])
  		.toStates(LifecycleState.DESTROYING, LifecycleState.DESTROYED)
  		.withEvents(LifecycleEvent.PRE_DESTROY, LifecycleEvent.DESTROY, LifecycleEvent.POST_DESTROY)
  		.inReverse();
	}
	
	int flipPriority(String type, int priority)
	{
		return (priority == 0 && _reversedEventTypes[type])
  		? _reversePriority++
  		: priority;
	}
	
	//TODO
	Function createSyncLifecycleListener(Function handler, [bool once = false])
	{
		//TODO: implement handler typedef
		
		/*return () {
			
			if (once)
				
				
		};*/
		
		return (event) {
    				handler();
    			};
		
		
	}
	
	void _reportError(String message)
	{
		/*LifecycleError error = new LifecycleError(message);
		if (hasEventListener(LifecycleEvent.ERROR))
		{
  		const event:LifecycleEvent = new LifecycleEvent(LifecycleEvent.ERROR, error);
			dispatchEvent(event);
  	}
  	else
  	{
  		throw error;
  	}*/
	}
}