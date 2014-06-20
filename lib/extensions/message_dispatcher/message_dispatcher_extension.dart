part of robotlegs;

class MessageDispatcherExtension implements IExtension
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IContext _context;
	
	IMessageDispatcher _messageDispatcher;
	
	//LifecycleMessageRelay _lifecycleRelay;
	
	//-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	MessageDispatcherExtension([this._messageDispatcher = null])
	{
		if (_messageDispatcher == null)
			_messageDispatcher = new MessageDispatcher();
	}
	
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