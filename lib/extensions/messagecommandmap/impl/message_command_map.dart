part of robotlegs;

class MessageCommandMap implements IMessageCommandMap
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final List _mappingProcessors  = [];
	
	IInjector _injector;
	
	IMessageDispatcher _dispatcher;
	
	CommandTriggerMap _triggerMap;
	
	ILogger _logger;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	MessageCommandMap(IContext context, IMessageDispatcher dispatcher)
	{
		_injector = context.injector;
		_logger = context.getLogger(this);
		_dispatcher = dispatcher;
		_triggerMap = new CommandTriggerMap(_getKey, _createTrigger);
	}
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	ICommandMapper map(Symbol name, Type messageType)
	{
		return _getTrigger(name, messageType).createMapper();
	}

	ICommandUnmapper unmap(Symbol name, Type messageType)
	{
		return _getTrigger(name, messageType).createMapper();
	}
	
	IMessageCommandMap addMappingProcessor(Function handler)
	{
		if (!_mappingProcessors.contains(handler))
			_mappingProcessors.add(handler);
		
		return this;
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	String _getKey(Symbol name, Type messageType)
	{
		return name.getName() + messageType.toString();
	}

	MessageCommandTrigger _getTrigger(Symbol name, Type messageType)
	{
		return _triggerMap.getTrigger([name, messageType]) as MessageCommandTrigger;
	}
	
	MessageCommandTrigger _createTrigger(Symbol name, Type messageType)
	{
		return new MessageCommandTrigger(_injector, _dispatcher, name, messageType, _mappingProcessors, _logger);
	}
}