part of robotlegs;

class Mediator implements IMediator {
	
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	@inject
	IEventMap eventMap;
	
	/*
	 * TODO: [IEventDispatcher] should be replaced with a streams-based equivalent
	 */
	@inject
	IEventDispatcher eventDispatcher;
	
	dynamic _viewComponent;
	
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
	
	void addViewListener( String eventString, Function listener, Type eventType ) {
		
	}

	void addContextListener( String eventString, Function listener, Type eventType ) {
		
	}

	void removeViewListener( String eventString, Function listener, Type eventType ) {
		
	}

	void removeContextListener( String eventString, Function listener, Type eventType ) {
		
	}

	void dispatch( Stream stream ) {
		
	}
}