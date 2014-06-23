part of robotlegs;

class MediatorMap implements IMediatorMap, IViewHandler
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final Map _mappers = new Map();
	
	ILogger _logger;
	
	MediatorFactory _factory;
	
	MediatorViewHandler _viewHandler;
	
	final IMediatorUnmapper _nullUnmapper = new NullMediatorUnmapper();
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	MediatorMap(IContext context)
	{
		_logger = context.getLogger(this);
		_factory = new MediatorFactory(context.injector);
		_viewHandler = new MediatorViewHandler(_factory);
	}
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	IMediatorMapper mapMatcher(ITypeMatcher matcher)
	{
		IMediatorMapper mapper = _mappers[matcher.createTypeFilter().descriptor];
		
		if (mapper == null)
			mapper = _createMapper(matcher);
		
		return mapper;
	}
	
	IMediatorMapper map(Type type)
	{
		return mapMatcher(new TypeMatcher().allOf([type]));
	}
	
	IMediatorUnmapper unmapMatcher(ITypeMatcher matcher)
	{
		IMediatorUnmapper mapper = _mappers[matcher.createTypeFilter().descriptor];
		
		if (mapper == null)
    		mapper = _nullUnmapper;
		
		return mapper;
	}
	
	IMediatorUnmapper unmap(Type type)
	{
		return unmapMatcher(new TypeMatcher().allOf([type]));
	}
	
	void handleView(dom.Element view, Type type)
	{
		_viewHandler.handleView(view, type);
	}
	
	void mediate(dynamic item)
	{
		_viewHandler.handleItem(item, item.runtimeType);
	}

	void unmediate(dynamic item)
	{
		_factory.removeMediators(item);
	}
	
	void unmediateAll()
	{
		_factory.removeAllMediators();
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	IMediatorMapper _createMapper(ITypeMatcher matcher)
	{
		return new MediatorMapper(matcher.createTypeFilter(), _viewHandler, _logger);
	}
}