part of robotlegs;

class MediatorViewHandler
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	final List _mappings = [];
	
	Map _knownMappings = new Map();
	
	MediatorFactory _factory;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	MediatorViewHandler(_factory);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void addMapping(IMediatorMapping mapping)
	{
		if (!_mappings.contains(mapping))
			_mappings.add(mapping);
		_flushCache();
	}
	
	void removeMapping(IMediatorMapping mapping)
	{
		if (!_mappings.contains(mapping))
			return;
		
		_mappings.remove(mapping);
		_flushCache();
	}
	
	void handleView(dom.Element view, Type type)
	{
		final List interestedMappings = _getInterestedMappingsFor(view, type);
		if (interestedMappings != null)
			_factory.createMediators(view, type, interestedMappings);
	}
	
	void handleItem(dynamic item, Type type)
	{
		final List interestedMappings = _getInterestedMappingsFor(item, type);
		if (interestedMappings != null)
    	_factory.createMediators(item, type, interestedMappings);
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
	
	List _getInterestedMappingsFor(dynamic item, Type type)
	{
		IMediatorMapping mapping;
		
		if (_knownMappings[type] == false)
			return null;
		
		if (_knownMappings[type] == null)
		{
			_knownMappings[type] = false;
			_mappings.forEach((mapping){
				if (mapping.matcher.matches(item))
				{
					if (_knownMappings[type] == false)
						_knownMappings[type] = [];
					_knownMappings[type].add(mapping);
				}
			});
			
			if (_knownMappings[type] == false)
   			return null;
		}
		
		return _knownMappings[type];
	}
}