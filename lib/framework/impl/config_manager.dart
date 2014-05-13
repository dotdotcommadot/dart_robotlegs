part of robotlegs;

class ConfigManager
{
	
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final ObjectProcessor _objectProcessor = new ObjectProcessor();
	
	final Map _configs = new Map();
	
	final List _queue = [];
	
	IInjector _injector;
	
	ILogger _logger;
	
	bool _initialized = false;

	//-----------------------------------
	//
	// Constructor
	//
	//-----------------------------------
	
	ConfigManager(IContext context)
	{
		_injector = context.injector;
		_logger = context.getLogger(this);
		addConfigHandler(new ClassMatcher(), _handleType);
		addConfigHandler(new ObjectMatcher(), _handleObject);
		
		// TODO: add stream-based equivalent
		//context.addEventListener(LifecycleEvent.INITIALIZE, initialize, false, -100); 
	}
	
	//-----------------------------------
	//
	// Public Methods
	//
	//-----------------------------------
	
	void addConfig(dynamic config)
	{
		if (_configs[config] == null)
		{
			_configs[config] = true;
			_objectProcessor.processObject(config);
		}
	}
	
	void addConfigHandler(IMatcher matcher, Function handler)
	{
		_objectProcessor.addObjectHandler(matcher, handler);
	}
	
	//-----------------------------------
	//
	// Private Methods
	//
	//-----------------------------------
	
	void _initalize(LifeCycleEvent event)
	{
		if (!_initialized)
		{
			_initialized = true;
			_processQueue();
		}
	}
	
	void _handleType(Type type)
	{
		if (_initialized)
		{
			_logger.debug("Already initialized. Instantiating config class {0}", [type]);
			_processType(type);
		}
		else
		{
			_logger.debug("Not yet initialized. Queuing config class {0}", [type]);
    	_queue.add(type);
		}
	}
	
	void _handleObject(dynamic object)
	{
		if (_initialized)
		{
			_logger.debug("Already initialized. Injecting into config object {0}", [object]);
			_processObject(object);
		}
		else
		{
			_logger.debug("Not yet initialized. Queuing config object {0}", [object]);
    	_queue.add(object);
		}
	}
	
	void _processQueue()
	{
		_queue.forEach( (dynamic config)
		{
			if (config is Type)
			{
				_logger.debug("Now initializing. Instantiating config class {0}", [config]);
				_processType(config as Type);
			}
			else
			{
				_logger.debug("Now initializing. Injecting into config object {0}", [config]);
				_processObject(config);
			}
		});
		
		_queue.clear();
	}
	
	void _processType(Type type)
	{
		final IConfig config = _injector.getOrCreateNewInstance(type) as IConfig;
		(config != null) && config.configure();
	}
	
	void _processObject(dynamic object)
	{
		_injector.injectInto(object);
		final IConfig config = object as IConfig;
		(config != null) && config.configure();
	}
}

class ClassMatcher implements IMatcher
{
	//-----------------------------------
	//
	// Public Methods
	//
	//-----------------------------------
	
	bool matches(dynamic item)
	{
		return item is Type;
	}
}

class ObjectMatcher implements IMatcher
{
	//-----------------------------------
	//
	// Public Methods
	//
	//-----------------------------------
	
	bool matches(dynamic item)
	{
		return item is! Type;
	}
}