part of robotlegs;

class Mediator implements IMediator 
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
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
	
	void dispatch(Symbol name, [dynamic data = null]) 
	{
		messageDispatcher.send(name, data);
	}
}