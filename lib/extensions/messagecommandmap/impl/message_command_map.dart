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
	
	ICommandMapper map(Symbol name)
	{
		return _getTrigger(name).createMapper();
	}

	ICommandUnmapper unmap(Symbol name)
	{
		return _getTrigger(name).createMapper();
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
	
	String _getKey(Symbol name)
	{
		return MirrorSystem.getName(name);
	}

	MessageCommandTrigger _getTrigger(Symbol name)
	{
		return _triggerMap.getTrigger([name]) as MessageCommandTrigger;
	}
	
	MessageCommandTrigger _createTrigger(Symbol name)
	{
		return new MessageCommandTrigger(_injector, _dispatcher, name, _mappingProcessors, _logger);
	}
}