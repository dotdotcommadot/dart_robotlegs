part of robotlegs;

class CommandMappingList implements ICommandMappingList
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final Map _mappingsByCommand = new Map();

	List<ICommandMapping> _mappings = new List<ICommandMapping>();
	
	ICommandTrigger _trigger;
	
	List _processors;
	
	ILogger _logger;
	
	Function _compareFunction;
	
	bool _sorted;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	CommandMappingList(this._trigger, this._processors, this._logger);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	List<ICommandMapping> getList()
	{
		_sorted || _sortMappings();
		return _mappings;
	}
	
	ICommandMappingList withSortFunction(Function sorter)
	{
		_sorted = false;
		_compareFunction = sorter;
		return this;
	}
	
	void addMapping(ICommandMapping mapping)
	{
		_sorted = false;
		_applyProcessors(mapping);
		final ICommandMapping oldMapping = _mappingsByCommand[mapping.commandType];
		if (oldMapping != null)
		{
			_overwriteMapping(oldMapping, mapping);
		}
		else
		{
			_storeMapping(mapping);
    	_mappings.length == 1 && _trigger.activate();
		}
	}
	
	void removeMapping(ICommandMapping mapping)
	{
		if (_mappingsByCommand[mapping.commandType])
	  {
			_deleteMapping(mapping);
	  	_mappings.length == 0 && _trigger.deactivate();
	  }
	}
	
	void removeMappingFor(Type commandType)
	{
		final ICommandMapping mapping = _mappingsByCommand[commandType];
		mapping && removeMapping(mapping);
	}
	
	void removeAllMappings()
	{
		if (_mappings.length > 0)
		{
			final List<ICommandMapping> list = _mappings;
			int length = list.length;
			while (length--)
			{
				_deleteMapping(list[length]);
			}
			_trigger.deactivate();
		}
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _storeMapping(ICommandMapping mapping)
	{
		_mappingsByCommand[mapping.commandType] = mapping;
  	_mappings.add(mapping);
  	_logger && _logger.debug('{0} mapped to {1}', [_trigger, mapping]);
	}

	void _deleteMapping(ICommandMapping mapping)
	{
		_mappingsByCommand.remove(mapping.commandType);
  	_mappings.remove(mapping);
  	_logger && _logger.debug('{0} unmapped from {1}', [_trigger, mapping]);
	}
	
	void _overwriteMapping(ICommandMapping oldMapping, ICommandMapping newMapping)
	{
		_logger && _logger.warn('{0} already mapped to {1}\n' +
	 	 'If you have overridden this mapping intentionally you can use "unmap()" ' +
	  	'prior to your replacement mapping in order to avoid seeing this message.\n',
	  	[_trigger, oldMapping]);
	  _deleteMapping(oldMapping);
	  _storeMapping(newMapping);
	}

	void _sortMappings()
	{
		if (_compareFunction != null)
	  {
	  	_mappings.sort(_compareFunction);
	  }
	  _sorted = true;
	}
	
	void _applyProcessors(ICommandMapping mapping)
	{
		_processors.forEach( (Function processor) => processor(mapping));
	}
}