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
	
	List _guards = [];
	List get guards => _guards;
	
	List _hooks = [];
	List get hooks => _hooks;
	
	bool _fireOnce = false;
	bool get fireOnce => _fireOnce;

	bool _payloadInjectionEnabled = true;
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
		_guards.addAll(guards);
		return this;
	}
	
	ICommandMapping addHooks(List hooks)
	{
		_hooks.addAll(hooks);
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