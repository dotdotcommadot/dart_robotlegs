part of robotlegs;

class MessageCommandTrigger implements ICommandTrigger
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IMessageDispatcher _dispatcher;
	
	Symbol _name;
	
	Type _messageType;
	
	ICommandMappingList _mappings;
	
	ICommandExecutor _executor;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	MessageCommandTrigger(
		IInjector injector,
		IMessageDispatcher dispatcher,
		Symbol name,
		[Type messageType = null,
		 List processors = null,
		 ILogger logger = null])
	{
		_dispatcher = dispatcher;
		_name = name;
		_messageType = messageType;
		_mappings = new CommandMappingList(this, processors, logger);
  	_executor = new CommandExecutor(injector, _mappings.removeMapping);
	}
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	CommandMapper createMapper()
	{
		return new CommandMapper(_mappings);
	}
	
  void activate()
  {
  	_dispatcher.addListener(_name, messageHandler);
  }
  
  void deactivate()
  {
  	_dispatcher.removeListener(_name, messageHandler);
  }
  
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
  
  void messageHandler(Message message)
  {
  	final Type messageConstructor = message.runtimeType;
  	Type payloadMessageType;
  	
  	if (messageConstructor == _messageType || _messageType == null)
  	{
  		payloadMessageType = messageConstructor;
  	}
  	else if (_messageType == Message)
  	{
  		payloadMessageType = _messageType;
  	}
  	else
  	{
  		return;
  	}
  	
  	_executor.executeCommands(_mappings.getList(), new CommandPayload([message], [payloadMessageType]));
  }
}