part of robotlegs;

class ViewProcessorMap implements IViewProcessorMap, IViewHandler
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	Map _mappers = new Map();
	
	IViewProcessorViewHandler _handler;
	
	final IViewProcessorUnmapper NULL_MAPPER = new NullViewProccesorUnmapper();
	
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	ViewProcessorMap(IViewProcessorFactory factory, [this._handler = null])
	{
		if (_handler == null)
			_handler = new ViewProcessorViewHandler(factory);
	}
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	IViewProcessorMapper mapMatcher(ITypeMatcher matcher)
	{
		if (_mappers[matcher.createTypeFilter().descriptor] == null)
			_mappers[matcher.createTypeFilter().descriptor] = createMapper(matcher);
		
		return _mappers[matcher.createTypeFilter().descriptor];
	}
	
	IViewProcessorMapper map(Type type)
	{
		ITypeMatcher matcher = new TypeMatcher().allOf(type);
		return mapMatcher(matcher);
	}
	
	IViewProcessorUnmapper unmapMatcher(ITypeMatcher matcher)
	{
		if (_mappers[matcher.createTypeFilter().descriptor] != null)
			return _mappers[matcher.createTypeFilter().descriptor];

		return NULL_MAPPER;
	}
	
	IViewProcessorUnmapper unmap(Type type)
	{
		final ITypeMatcher matcher = new TypeMatcher().allOf(type);
		return unmapMatcher(matcher);
	}
	
	void process(dynamic item)
	{
		final Type type = item.runtimeType;
		_handler.processItem(item, type);
	}

	void unprocess(dynamic item)
	{
		final Type type = item.runtimeType;
		_handler.unprocessItem(item, type);
	}

	void handleView(dynamic view, Type type)
	{
		_handler.processItem(view, type);
	}
	
	IViewProcessorMapper createMapper(ITypeMatcher matcher)
	{
		return new ViewProcessorMapper(matcher.createTypeFilter(), _handler);
	}
}