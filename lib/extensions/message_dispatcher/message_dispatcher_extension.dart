part of robotlegs;

class MessageDispatcherExtension implements IExtension
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IContext _context;
	
	IMessageDispatcher _messageDispatcher = new MessageDispatcher();
	
	//LifecycleMessageRelay _lifecycleRelay;
	
	//-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		_context = context;
		_context.injector.map(IMessageDispatcher).toValue(_messageDispatcher);
		/*_context.beforeInitializing(configureLifecycleEventRelay);
		_context.afterDestroying(destroyLifecycleEventRelay);*/
	}
	
	//-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	/*void _configureLifecycleEventRelay()
	{
		_lifecycleRelay = new LifecycleEventRelay(_context, _eventDispatcher);
	}
	
	void _destroyLifecycleEventRelay()
	{
		_lifecycleRelay.destroy();
	}*/
}