part of robotlegs;

class CommandMapping implements ICommandMapping
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	Type _commandType;
	Type get commandType => _commandType;
	
	Symbol _executeMethod = new Symbol("execute");
	Symbol get executeMethod => _executeMethod;
	
	List _guards;
	List get guards => _guards;
	
	List _hooks;
	List get hooks => _hooks;
	
	bool _fireOnce;
	bool get fireOnce => _fireOnce;

	bool _payloadInjectionEnabled;
	bool get payloadInjectionEnabled => _payloadInjectionEnabled;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	CommandMapping(this._commandType) ;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	ICommandMapping setExecuteMethod(Symbol name)
	{
		_executeMethod = name;
  	return this;
	}

	ICommandMapping addGuards(List guards)
	{
		// TODO: convert to Dart
		//_guards = _guards.concat.apply(null, guards);
		return this;
	}
	
	ICommandMapping addHooks(List hooks)
	{
		// TODO: convert to Dart
		//_hooks = _hooks.concat.apply(null, guards);
		return this;
	}
	
	ICommandMapping setFireOnce(bool value)
	{
		_fireOnce = value;
  	return this;
	}

	ICommandMapping setPayloadInjectionEnabled(bool value)
	{
		_payloadInjectionEnabled = value;
		return this;
	}
	
	String toString()
	{
		return 'Command ' + _commandType.runtimeType.toString();
	}
}