part of robotlegs;

class ViewProcessorMapper implements IViewProcessorMapper, IViewProcessorUnmapper
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final Map _mappings = new Map();
	
	IViewProcessorViewHandler _handler;
	
	ITypeFilter _matcher;
	
	ILogger _logger;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	ViewProcessorMapper(this._matcher, this._handler, [this._logger = null]);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	IViewProcessorMappingConfig toProcess(dynamic processClassOrInstance)
	{
		final IViewProcessorMapping mapping = _mappings[processClassOrInstance];
		
		if (mapping == null)
			return _createMapping(processClassOrInstance);
		else
			return _overwriteMapping(mapping, processClassOrInstance);
	}
	
	IViewProcessorMappingConfig toInjection()
	{
		return toProcess(ViewInjectionProcessor);
	}
	
	IViewProcessorMappingConfig toNoProcess()
	{
		return toProcess(NullProcessor);
	}
	
	void fromProcess(dynamic processorClassOrInstance)
	{
		final IViewProcessorMapping mapping = _mappings[processorClassOrInstance];
		if (mapping != null)
			_deleteMapping(mapping);
	}
	
	void fromAll()
	{
		_mappings.forEach( (processor, mapping) {
			fromProcess(processor);
		});
	}
	
	void fromNoProcess()
	{
		fromProcess(NullProcessor);
	}

	void fromInjection()
	{
		fromProcess(ViewInjectionProcessor);
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	ViewProcessorMapping _createMapping(dynamic processor)
	{
		final ViewProcessorMapping mapping = new ViewProcessorMapping(_matcher, processor);
		_handler.addMapping(mapping);
		_mappings[processor] = mapping;
		if (_logger != null) 
			_logger.debug('{0} mapped to {1}', [_matcher, mapping]);
		return mapping;
	}
	
	void _deleteMapping(IViewProcessorMapping mapping)
	{
		_handler.removeMapping(mapping);
		_mappings.remove(mapping.processor);
		if (_logger != null) 
    	_logger.debug('{0} unmapped from {1}', [_matcher, mapping]);
	}
	
	IViewProcessorMappingConfig _overwriteMapping(IViewProcessorMapping mapping, dynamic processClassOrInstance)
	{
		if (_logger != null)
			_logger.warn('{0} is already mapped to {1}.\n' +
      'If you have overridden this mapping intentionally you can use "unmap()" ' +
      'prior to your replacement mapping in order to avoid seeing this message.\n',
      [_matcher, mapping]);
		
		_deleteMapping(mapping);
		return _createMapping(processClassOrInstance);
	}
}