part of robotlegs;

class CommandExecutor implements ICommandExecutor
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IInjector _injector;
	
	Function _removeMapping;
	
	Function _handleResult;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	CommandExecutor(this._injector, [this._removeMapping = null, this._handleResult = null]);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
  void executeCommand(ICommandMapping mapping, [CommandPayload payload = null])
  {
  	final bool hasPayload = (payload != null && payload.hasPayload());
  	final bool injectionEnabled = (hasPayload && mapping.payloadInjectionEnabled);
  	dynamic command = null;
  	
  	if (injectionEnabled)
  		_mapPayload(payload);
  	
  	if (mapping.guards.length == 0 || guardsApprove(mapping.guards, _injector))
  	{
  		final Type commandType = mapping.commandType;
  		
  		if (mapping.fireOnce && _removeMapping != null)
  			_removeMapping(mapping);
  		
  		command = _injector.getOrCreateNewInstance(commandType);
  		
  		if (mapping.hooks.length > 0)
  		{
  			_injector.map(commandType).toValue(command);
  			applyHooks(mapping.hooks, _injector);
  			_injector.unmap(commandType);
  		}
  		
  		if (injectionEnabled)
  			_unmapPayload(payload);
  		
  		if (command != null && mapping.executeMethod != null)
  		{
  			final Function executeMethod = command[mapping.executeMethod];
  			final dynamic result = Function.apply(executeMethod, payload.values);
  			
  			if (_handleResult != null)
  				Function.apply(_handleResult, [result, command, mapping]);
  		}
  	}
  }
  
  void executeCommands(List<ICommandMapping> mappings, [CommandPayload payload = null])
  {
  	final int length = mappings.length;
  	for (int i = 0; i < length; i++)
  	{
  		executeCommand(mappings[i], payload);
  	}
  }
  
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
  
  void _mapPayload(CommandPayload payload)
  {
  	for (int i = payload.length; i > 0; i--)
  	{
  		_injector.map(payload.types[i]).toValue(payload.values[i]);
  	}
  }
  
  void _unmapPayload(CommandPayload payload)
  {
  	for (int i = payload.length; i > 0; i--)
  	{
  		_injector.unmap(payload.types[i]);
  	}
  }
}