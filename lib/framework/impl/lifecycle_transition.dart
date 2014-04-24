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
	
	String _preTransitionState;
	
	String _transitionEvent;
	
	String _postTransitionEvent;
	
	bool _reverse;
	
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
		// TODO
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
		(state != null) && _lifecycle.setCurrentState(state);
	}
	
	/*void _dispatch(String type)
	{
		
	}*/
	
	void _reportError(dynamic message, List callbacks)
	{
		// TODO
	}
}