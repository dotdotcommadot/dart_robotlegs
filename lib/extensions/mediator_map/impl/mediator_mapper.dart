part of robotlegs;

class MediatorMapper implements IMediatorMapper, IMediatorUnmapper
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	Map<Type, IMediatorMapping> _mappings = new Map<Type, IMediatorMapping>();
	
	ITypeFilter _typeFilter;
	
	MediatorViewHandler _handler;
	
	ILogger _logger;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	MediatorMapper(this._typeFilter, this._handler, this._logger);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	IMediatorConfigurator toMediator(Type mediatorType)
	{
		final IMediatorMapping mapping = _mappings[mediatorType];
		return (mapping != null)
				? _overwriteMapping(mapping)
	      : _createMapping(mediatorType);
	}
	
	void fromMediator(Type mediatorType)
	{
		final IMediatorMapping mapping = _mappings[mediatorType];
		if (mapping != null)
			_deleteMapping(mapping);
	}
	
	void fromAll()
	{
		_mappings.forEach((key, mapping) => _deleteMapping(mapping));
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	MediatorMapping _createMapping(Type mediatorType)
	{
		final MediatorMapping mapping = new MediatorMapping(_typeFilter, mediatorType);
		_handler.addMapping(mapping);
		_mappings[mediatorType] = mapping;
		if (_logger != null)
			_logger.debug('{0} unmapped from {1}', [_typeFilter, mapping]);
		return mapping;
	}
	
	void _deleteMapping(IMediatorMapping mapping)
	{
		_handler.removeMapping(mapping);
		_mappings.remove(mapping.mediatorType);
		if (_logger != null)
			_logger.debug('{0} unmapped from {1}', [_typeFilter, mapping]);
	}
	
	IMediatorConfigurator _overwriteMapping(IMediatorMapping mapping)
	{
		if (_logger != null)
			_logger.warn('{0} already mapped to {1}\n' +
      'If you have overridden this mapping intentionally you can use "unmap()" ' +
      'prior to your replacement mapping in order to avoid seeing this message.\n',
      [_typeFilter, mapping]);
		
		_deleteMapping(mapping);
  	return _createMapping(mapping.mediatorType);
	}
}