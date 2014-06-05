part of robotlegs;

class CommandMapper implements ICommandMapper, ICommandUnmapper, ICommandConfigurator
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	ICommandMappingList _mappings;

	ICommandMapping _mapping;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	CommandMapper(this._mappings);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	ICommandConfigurator toCommand(Type commandType)
	{
		_mapping = new CommandMapping(commandType);
		_mappings.addMapping(_mapping);
		return this;
	}
	
	void fromCommand(Type commandType)
	{
		_mappings.removeMappingFor(commandType);
	}
	
	void fromAll()
	{
		_mappings.removeAllMappings();
	}
	
	ICommandConfigurator once([bool value = true])
	{
		_mapping.setFireOnce(value);
  	return this;
	}
	
	ICommandConfigurator withGuards(List guards)
	{
		_mapping.addGuards(guards);
  	return this;
	}

	ICommandConfigurator withHooks(List hooks)
	{
		_mapping.addHooks(hooks);
		return this;
	}
	
	ICommandConfigurator withExecuteMethod(Symbol name)
	{
		_mapping.setExecuteMethod(name);
  	return this;
	}
	
	ICommandConfigurator withPayloadInjection([bool value = true])
	{
		_mapping.setPayloadInjectionEnabled(value);
  	return this;
	}
}