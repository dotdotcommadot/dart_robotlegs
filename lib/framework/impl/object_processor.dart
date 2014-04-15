part of robotlegs;

class ObjectProcessor 
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final List<ObjectHandler> _handlers = [];
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void addObjectHandler(IMatcher matcher, Function handler)
	{
		_handlers.add(new ObjectHandler(matcher, handler));
	}
	
	void processObject(dynamic object)
	{
		_handlers.forEach( (ObjectHandler handler)
		{
			handler.handle(object);
		});
	}
}

class ObjectHandler
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IMatcher _matcher;
	
	Function _handler;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	ObjectHandler(this._matcher, this._handler);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void handle(dynamic object)
	{
		_matcher.matches(object) && _handler(object);
	}
}