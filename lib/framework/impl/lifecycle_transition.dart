part of robotlegs;

class LifecycleTransition
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	final List<String> _fromStates = new List<String>();
	
	final MessageDispatcher _dispatcher = new MessageDispatcher();
	
	final List _callbacks = [];
	
	String _name;
	
	Lifecycle _lifecycle;
	
	String _transitionState;
	
	String _finalState;
	
	String _preTransitionEvent;
	
	String _transitionEvent;
	
	String _postTransitionEvent;
	
	bool _reverse = false;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	LifecycleTransition(this._name, this._lifecycle);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	LifecycleTransition fromStates(List states)
	{
		states.forEach( (String state)
		{
			_fromStates.add(state);
		});
		return this;
	}
	
	LifecycleTransition toStates(String transitionState, String finalState)
	{
		_transitionState = transitionState;
		_finalState = finalState;
		return this;
	}
	
	//TODO
	LifecycleTransition withEvents(String preTransitionEvent, String transitionEvent, String postTransitionEvent)
	{
		_preTransitionEvent = preTransitionEvent;
		_transitionEvent = transitionEvent;
		_postTransitionEvent = postTransitionEvent;
		
		if (_reverse)
			_lifecycle._addReversedEventTypes([preTransitionEvent, transitionEvent, postTransitionEvent]);
		
		return this;
	}
	
	LifecycleTransition inReverse()
	{
		_reverse = true;
		//TODO: _lifecycle.addReversedEventTypes(_preTransitionEvent, _transitionEvent, _postTransitionEvent);
		return this;
	}
	
	LifecycleTransition addBeforeHandler(Function handler)
	{
		_dispatcher.addMessageHandler(_name, handler);
		return this;
	}
	
	void enter([Function callback = null])
	{
		if (_lifecycle.state == _finalState)
		{
			if (callback != null)
				safelyCallback(callback, null, _name);
			
			return;
		}
		
		if (_lifecycle.state == _transitionState)
		{
			if (callback != null)
				_callbacks.add(callback);
			return;
		}
		
		if (_invalidTransition())
		{
			_reportError("Invalid transition", [callback]);
			return;
		}
		
		final String initialState = _lifecycle.state;
		
		if (callback != null)
			_callbacks.add(callback);
		
		_setState(_transitionState);
		
		_dispatcher.dispatchMessage(_name, (error) 
		{
			if (error != null)
			{
				_setState(initialState);
				_reportError(error, _callbacks);
				return;
			}
			
			_dispatch(_preTransitionEvent);
	    _dispatch(_transitionEvent);
	    
	    _setState(_finalState);
	    
	    final List callbacks = _callbacks;
	    _callbacks.length = 0;
	    
	    callbacks.forEach( (callback) {
	    	safelyCallback(callback, null, _name);
	    });
	    
	    _dispatch(_postTransitionEvent);
		
		}, _reverse);
}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	bool _invalidTransition()
	{
		return _fromStates.length > 0
				&& _fromStates.indexOf(_lifecycle.state) == -1;
	}
	
	void _setState(String state)
	{
		if (state != null)
			_lifecycle.setCurrentState(state);
	}
	
	void _dispatch(String type)
	{
		print(type);
		// TODO
	}
	
	void _reportError(dynamic message, List callbacks)
	{
		// TODO
	}
}