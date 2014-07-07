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

	MessageDispatcher _dispatcher;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	Lifecycle(this._target)
	{
		if (target != null) 
			_dispatcher = target as MessageDispatcher;
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
		_dispatcher.addListener(LifecycleMessage.INITIALIZE, createSyncLifecycleListener(handler));
  	return this;
	}

	ILifecycle afterInitializing(Function handler)
	{
		if (initialized)
			_reportError(LifecycleError.LATE_HANDLER_ERROR_MESSAGE);
		_dispatcher.addListener(LifecycleMessage.POST_INITIALIZE, createSyncLifecycleListener(handler));
  	return this;
	}

	ILifecycle beforeSuspending(Function handler)
	{
		_suspend.addBeforeHandler(handler);
  	return this;
	}

	ILifecycle whenSuspending(Function handler)
	{
		_dispatcher.addListener(LifecycleMessage.SUSPEND, createSyncLifecycleListener(handler));
  	return this;
	}

	ILifecycle afterSuspending(Function handler)
	{
		_dispatcher.addListener(LifecycleMessage.POST_SUSPEND, createSyncLifecycleListener(handler));
 		return this;
	}

	ILifecycle beforeResuming(Function handler)
	{
		_resume.addBeforeHandler(handler);
  	return this;
	}

	ILifecycle whenResuming(Function handler)
	{
		_dispatcher.addListener(LifecycleMessage.RESUME, createSyncLifecycleListener(handler));
  	return this;
	}

	ILifecycle afterResuming(Function handler)
	{
		_dispatcher.addListener(LifecycleMessage.POST_RESUME, createSyncLifecycleListener(handler));
  	return this;
	}

	ILifecycle beforeDestroying(Function handler)
	{
		_destroy.addBeforeHandler(handler);
  	return this;
	}

	ILifecycle whenDestroying(Function handler)
	{
		_dispatcher.addListener(LifecycleMessage.DESTROY, createSyncLifecycleListener(handler));
  	return this;
	}

	ILifecycle afterDestroying(Function handler)
	{
		_dispatcher.addListener(LifecycleMessage.POST_DESTROY, createSyncLifecycleListener(handler));
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
	void dispatchEvent(Symbol messageName)
	{
		return _dispatcher.send(messageName);
	}

	//TODO
	bool hasEventListener(Symbol messageName)
	{
		return _dispatcher.hasListener(messageName);
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
		
		dispatchEvent(LifecycleMessage.STATE_CHANGE);
	}
	
	void _addReversedEventTypes(List types)
	{
		types.forEach((type) {
			_reversedEventTypes[type] = true;
		});
	}
	
	void _configureTransitions()
	{
		_initialize = new LifecycleTransition(LifecycleMessage.PRE_INITIALIZE, this)
  		.fromStates([LifecycleState.UNINITIALIZED])
  		.toStates(LifecycleState.INITIALIZING, LifecycleState.ACTIVE)
  		.withMessages(LifecycleMessage.PRE_INITIALIZE, LifecycleMessage.INITIALIZE, LifecycleMessage.POST_INITIALIZE);

		_suspend = new LifecycleTransition(LifecycleMessage.PRE_SUSPEND, this)
  		.fromStates([LifecycleState.ACTIVE])
  		.toStates(LifecycleState.SUSPENDING, LifecycleState.SUSPENDED)
  		.withMessages(LifecycleMessage.PRE_SUSPEND, LifecycleMessage.SUSPEND, LifecycleMessage.POST_SUSPEND)
  		.inReverse();

		_resume = new LifecycleTransition(LifecycleMessage.PRE_RESUME, this)
  		.fromStates([LifecycleState.SUSPENDED])
  		.toStates(LifecycleState.RESUMING, LifecycleState.ACTIVE)
  		.withMessages(LifecycleMessage.PRE_RESUME, LifecycleMessage.RESUME, LifecycleMessage.POST_RESUME);

		_destroy = new LifecycleTransition(LifecycleMessage.PRE_DESTROY, this)
  		.fromStates([LifecycleState.SUSPENDED, LifecycleState.ACTIVE])
  		.toStates(LifecycleState.DESTROYING, LifecycleState.DESTROYED)
  		.withMessages(LifecycleMessage.PRE_DESTROY, LifecycleMessage.DESTROY, LifecycleMessage.POST_DESTROY)
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