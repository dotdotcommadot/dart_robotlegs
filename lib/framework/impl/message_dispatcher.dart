part of robotlegs;

class MessageDispatcher
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	final Map<dynamic, List> _handlers = new Map<dynamic, List>();
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void addMessageHandler(dynamic message, Function handler)
	{
		final List messageHandlers = _handlers[message];
		if (messageHandlers != null)
		{
			if (messageHandlers.indexOf(handler) == -1)
				messageHandlers.add(handler);
			else
				_handlers[message] = [handler];
		}
	}
	
	bool hasMessageHandler(dynamic message)
	{
		return (_handlers[message] != null);
	}

	void removeMessageHandler(dynamic message, Function handler)
	{
		final List messageHandlers = _handlers[message];
		int index = (messageHandlers != null) ? messageHandlers.indexOf(handler) : -1;
		if (index != -1)
		{
			messageHandlers.removeAt(index);
			if (messageHandlers.length == 0)
				_handlers.remove(message);
		}
	}
	
	void dispatchMessage(dynamic message, [Function callback = null, bool reverse = false])
	{
		List handlers = _handlers[message];
		if (handlers != null)
		{
			// TODO
			new MessageRunner(message, handlers, callback).run();
		}
		else
		{
			// TODO (callback != null) && safelyCallBack(callback);
		}
	}
}

class MessageRunner
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	dynamic _message;
	
	List _handlers;
	
	Function _callback;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	MessageRunner(this._message, this._handlers, this._callback);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void run()
	{
		_next();
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _next()
	{
		// TODO
	}
}