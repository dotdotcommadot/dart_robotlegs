part of robotlegs;

class MediatorFactory
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	Map _mediators = new Map();
	
	IInjector _injector;
	
	MediatorManager _manager;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	MediatorFactory(this._injector, [this._manager = null])
	{
		if (_manager == null)
			_manager = new MediatorManager(this);
	}
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	dynamic getMediator(dom.Element item, IMediatorMapping mapping)
	{
		return _mediators[item] == null
		   ? _mediators[item][mapping]
		   : null;
	}
	
	List<dynamic> createMediators(dynamic item, Type type, List mappings)
	{
		final List<dynamic> createdMediators = [];
		dynamic mediator;
		
		mappings.forEach((mapping){
			mediator = getMediator(item, mapping);
			
			if (mediator == null)
			{
				mapTypeForFilterBinding(mapping.matcher, type, item);
	      mediator = _createMediator(item, mapping);
	      unmapTypeForFilterBinding(mapping.matcher, type, item);
			}
			
			if (mediator != null)
				createdMediators.add(mediator);
		});
		
		return createdMediators;
	}
	
	void removeMediators(dynamic item)
	{
		final Map mediators = _mediators[item];
		if (mediators == null || mediators.length == 0)
			return;
		
		mediators.forEach((key, mapping)
		{
			_manager.removeMediator(mediators[mapping], item, mapping as IMediatorMapping);
		});
		
		mediators.remove(item);
	}
	
	void removeAllMediators()
	{
		_mediators.forEach((key, item){
			removeMediators(item);
		});
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	dynamic _createMediator(dynamic item, IMediatorMapping mapping)
	{
		dynamic mediator = getMediator(item, mapping);
		
		if (mediator != null)
			return mediator;
		
		if (mapping.guards.length == 0 || guardsApprove(mapping.guards, _injector))
		{
			final Type mediatorType = mapping.mediatorType;
			
			mediator = _injector.instantiateUnmapped(mediatorType);
	    if (mapping.hooks.length > 0)
	    {
		    _injector.map(mediatorType).toValue(mediator);
		    applyHooks(mapping.hooks, _injector);
		    _injector.unmap(mediatorType);
	    }
	    	addMediator(mediator, item, mapping);
		}
		return mediator;
	}
	
	void addMediator(dynamic mediator, dynamic item, IMediatorMapping mapping)
	{
		if (_mediators[item] == null)
			_mediators[item] = new Map();
		
		_mediators[item][mapping] = mediator;
		_manager.addMediator(mediator, item, mapping);
	}
	
	void mapTypeForFilterBinding(ITypeFilter filter, Type type, dynamic item)
	{
		final List<Type> requiredTypes = requiredTypesFor(filter, type);
    		
  	requiredTypes.forEach((requiredType){
  		_injector.map(requiredType).toValue(item);
  	});
	}
	
	void unmapTypeForFilterBinding(ITypeFilter filter, Type type, dynamic item)
	{
		final List<Type> requiredTypes = requiredTypesFor(filter, type);
      		
  	requiredTypes.forEach((requiredType){
  		if (_injector.satisfiesDirectly(requiredType))
   			_injector.unmap(requiredType);
  	});
	}
	
	List<Type> requiredTypesFor(ITypeFilter filter, Type type)
	{
		final List<Type> requiredTypes = filter.allOfTypes;
		requiredTypes.addAll(filter.anyOfTypes);
		
		if (!requiredTypes.contains(type))
			requiredTypes.add(type);
		
		return requiredTypes;
	}
}