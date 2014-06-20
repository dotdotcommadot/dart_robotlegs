part of robotlegs;

class Mediator implements IMediator 
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	Map<StreamController, StreamSubscription> _subscriptions = new Map<StreamController, StreamSubscription>();
	
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	/*
	 * TODO: [IMessageDispatcher] should be replaced with a streams-based equivalent
	 */
	@inject
	IMessageDispatcher messageDispatcher;
	
	dynamic viewComponent;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	Mediator();
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void preInitialize() {}

	void initialize() {}

	void postInitialize() {}

	void preDestroy() {}
	
	void destroy() {}

	void postDestroy() {}
	
	void addStreamListener(Stream stream, Function handler) 
	{
		stream.listen(handler);
	}


	void removeListener(StreamController streamController, Function handler) 
	{
		
	}

	void dispatch(Symbol name, [dynamic data = null]) 
	{
		messageDispatcher.send(name, data);
	}
}