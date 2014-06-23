part of robotlegs;

class ViewProcessorFactory implements IViewProcessorFactory
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IInjector _injector;
	
	Map<dynamic, List> _listenersByView = new Map<dynamic, List>();
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	ViewProcessorFactory(this._injector);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void runProcessors(dynamic view, Type type, List<IViewProcessorMapping> processorMappings)
	{
		_createRemovedListener(view, type, processorMappings);
		
		ITypeFilter filter;
		
		processorMappings.forEach(
			(mapping) {
			filter = mapping.matcher;
			_mapTypeForFilterBinding(filter, type, view);
	    _runProcess(view, type, mapping);
	    _unmapTypeForFilterBinding(filter, type, view);
		});
	}
	
	void runUnprocessors(dynamic view, Type type, List<IViewProcessorMapping> processorMappings)
	{
		processorMappings.forEach(
			(mapping) {
			
			if (mapping.processor == null)
				mapping.processor = _createProcessor(mapping.processorType);
			
			mapping.processor.unprocess(view, type, _injector);
		});
	}
	
	void runAllUnprocessors()
	{
		_listenersByView.forEach(
			(key, removalHandlers) {
			final int length = removalHandlers.length;
			
			for (int i = 0; i < length; i++)
				removalHandlers[i](null);
		});
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _runProcess(dynamic view, Type type, IViewProcessorMapping mapping)
	{
		if (guardsApprove(mapping.guards, _injector))
		{
			if (mapping.processor == null)
				mapping.processor = _createProcessor(mapping.processorType);
			
			applyHooks(mapping.hooks, _injector);
    	mapping.processor.process(view, type, _injector);
		}
	}
	
	dynamic _createProcessor(Type processorType)
	{
		if (!_injector.hasMapping(processorType))
	  {
	  	_injector.map(processorType).asSingleton();
	  }
		
		try
	  {
	  	return _injector.getInstance(processorType);
	  }
		catch (error)
	  {
			String errorMsg = "The view processor "
		  + processorType.runtimeType.toString()
		  + " has not been mapped in the injector, "
		  + "and it is not possible to instantiate an interface. "
		  + "Please map a concrete type against this interface.";
			
		  throw(new ViewProcessorMapError(errorMsg));
	  }
	  return null;
	}
	
	void _mapTypeForFilterBinding(ITypeFilter filter, Type type, dynamic view)
	{
		final List<Type> requiredtypes = _requiredTypesFor(filter, type);
		
		requiredtypes.forEach(
			(requiredType) {
			_injector.map(requiredType).toValue(view);
		});
	}

	void _unmapTypeForFilterBinding(ITypeFilter filter, Type type, dynamic view)
	{
		final List<Type> requiredtypes = _requiredTypesFor(filter, type);
		
		requiredtypes.forEach(
			(requiredType) {
			
			if (_injector.hasDirectMapping(requiredType))
				_injector.unmap(requiredType);
		});
	}

	List<Type> _requiredTypesFor(ITypeFilter filter, Type type)
	{
		List<Type> requiredTypes = filter.allOfTypes;
		requiredTypes.addAll(filter.anyOfTypes);
		
		if (!requiredTypes.contains(type))
			requiredTypes.add(type);
		
		return requiredTypes;
	}
	
	void _createRemovedListener(dynamic view, Type type, List<IViewProcessorMapping> processorMappings)
	{
		// TODO: implement
		/*if (view is dom.Element)
		{
			final Function handler = (_) {
		    runUnprocessors(view, type, processorMappings);
		    (view as Element).removeEventListener(Event.REMOVED_FROM_STAGE, handler);
		    _removeHandlerFromView(view, handler);
	    };
			
			_listenersByView[view].add(handler);
			(view as Element).addEventListener(Event.REMOVED_FROM_STAGE, handler, false, 0, true);
		}*/
	}
	
	void _removeHandlerFromView(dynamic view, Function handler)
	{
		if ((_listenersByView[view] != null) && (_listenersByView[view].length > 0))
		{
			_listenersByView[view].remove(handler);
			if (_listenersByView[view].length == 0)
				_listenersByView.remove(view);
		}
	}
}