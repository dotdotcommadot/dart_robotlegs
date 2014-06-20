part of robotlegs;

class CommandTriggerMap
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	Map _triggers = new Map();
	
	Function _keyFactory;
	
	Function _triggerFactory;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	CommandTriggerMap(this._keyFactory, this._triggerFactory);
	
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	ICommandTrigger getTrigger(List params)
	{
		final dynamic key = _getKey(params);
		ICommandTrigger trigger = _triggers[key];
		if (trigger == null)
			trigger = _createTrigger(params);
		
		return trigger;
	}
	
	ICommandTrigger removeTrigger(List params)
	{
		return _destroyTrigger(_getKey(params));
	}
	
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	dynamic _getKey(List mapperArgs)
	{
		return Function.apply(_keyFactory, mapperArgs);
	}

	ICommandTrigger _createTrigger(List mapperArgs)
	{
		return Function.apply(_triggerFactory, mapperArgs);
	}

	ICommandTrigger _destroyTrigger(dynamic key)
	{
		final ICommandTrigger trigger = _triggers[key];
		if (trigger != null)
		{
			trigger.deactivate();
			_triggers.remove(key);
		}
		return trigger;
	}
}