part of robotlegs;

class ViewProcessorViewHandler implements IViewProcessorViewHandler
{
	//-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final List _mappings = [];
	
	Map _knownMappings = new Map();
	
	IViewProcessorFactory _factory;
	
	//-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	ViewProcessorViewHandler(this._factory);
	
	//-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void addMapping(IViewProcessorMapping mapping)
	{
		if (_mappings.contains(mapping))
			return;
		
		_mappings.add(mapping);
		_flushCache();
	}

	void removeMapping(IViewProcessorMapping mapping)
	{
		if (!_mappings.contains(mapping))
			return;
		
		_mappings.remove(mapping);
		_flushCache();
	}

	void processItem(dynamic item, Type type)
	{
		final List interestedMappings = _getInterestedMappingsFor(item, type);
		if (interestedMappings != null)
			_factory.runProcessors(item, type, interestedMappings);
	}

	void unprocessItem(dynamic item, Type type)
	{
		final List interestedMappings = _getInterestedMappingsFor(item, type);
		if (interestedMappings != null)
			_factory.runUnprocessors(item, type, interestedMappings);
	}
	
	//-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _flushCache()
	{
		_knownMappings = new Map();
	}
	
	List _getInterestedMappingsFor(dynamic view, Type type)
	{
		if (_knownMappings[type] == false)
			return null;
		
		if (_knownMappings[type] == null)
		{
			_mappings.forEach((mapping)
			{
				if (mapping.matcher.matches(view))
				{
					if (_knownMappings[type] == null)
						_knownMappings[type] = [];
					
					_knownMappings[type].add(mapping);
				}
			});
			
			if (_knownMappings[type] == false)
				return null;
		}
		
		return _knownMappings[type] as List;
	}
}