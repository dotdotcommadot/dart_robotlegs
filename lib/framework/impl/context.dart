part of robotlegs;

class Context extends MessageDispatcher implements IContext
{
	
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	IInjector _injector = new RobotlegsInjector();
	IInjector get injector => _injector;
	
	int get logLevel => _logManager.logLevel;
	set logLevel(int value) => _logManager.logLevel = value;
	
	String get state => _lifecycle.state;
	
	bool get uninitialized => _lifecycle.uninitialized;

	bool get initialized => _lifecycle.initialized;
	
	bool get active => _lifecycle.active;
	
	bool get suspended => _lifecycle.suspended;

	bool get destroyed => _lifecycle.destroyed;
	
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	LogManager _logManager = new LogManager();
	
	List _children = [];
	
	Pin _pin;
	
	Lifecycle _lifecycle;
	
	ConfigManager _configManager;
	
	ExtensionInstaller _extensionInstaller;
	
	ILogger _logger;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	Context()
	{
		_setup();
	}
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void initialize([Function callback = null]) => _lifecycle.initialize(callback);

	void suspend([Function callback = null]) => _lifecycle.suspend(callback);

	void resume([Function callback = null]) => _lifecycle.resume(callback);

	void destroy([Function callback = null]) => _lifecycle.destroy(callback);

	IContext beforeInitializing(Function handler)
	{
		_lifecycle.beforeInitializing(handler);
		return this;
	}
	
	IContext whenInitializing(Function handler)
	{
		_lifecycle.whenInitializing(handler);
		return this;
	}

	IContext afterInitializing(Function handler)
	{
		_lifecycle.afterInitializing(handler);
		return this;
	}

	IContext beforeSuspending(Function handler)
	{
		_lifecycle.beforeSuspending(handler);
		return this;
	}
	
	IContext whenSuspending(Function handler)
	{
		_lifecycle.whenSuspending(handler);
		return this;
	}

	IContext afterSuspending(Function handler)
	{
		_lifecycle.afterSuspending(handler);
		return this;
	}

	IContext beforeResuming(Function handler)
	{
		_lifecycle.beforeResuming(handler);
		return this;
	}

	IContext whenResuming(Function handler)
	{
		_lifecycle.whenResuming(handler);
		return this;
	}

	IContext afterResuming(Function handler)
	{
		_lifecycle.afterResuming(handler);
		return this;
	}

	IContext beforeDestroying(Function handler)
	{
		_lifecycle.beforeDestroying(handler);
		return this;
	}

	IContext whenDestroying(Function handler)
	{
		_lifecycle.whenDestroying(handler);
		return this;
	}

	IContext afterDestroying(Function handler)
	{
		_lifecycle.afterDestroying(handler);
		return this;
	}
	
	IContext install(List<Type> extensions)
	{
		extensions.forEach((extension) => _extensionInstaller.install(extension));
		return this;
	}

	IContext configure(List configs)
	{
		configs.forEach((config) => _configManager.addConfig(config));
		return this;
	}
	
	IContext addChild(IContext child)
	{
		if (_children.indexOf(child) == -1)
		{
			_logger.info("Adding child context {0}", [child]);
			if(!child.uninitialized)
			{
				_logger.warn("Child context {0} must be uninitialized", [child]);
			}
			if (child.injector.parentInjector != null)
	    {
	    	_logger.warn("Child context {0} must not have a parent Injector", [child]);
	    }
			_children.add(child);
			child.injector.parentInjector = injector;
			//TODO: child.addEventListener(LifecycleEvent.POST_DESTROY, onChildDestroy);
		}
		return this;
	}
	
	IContext removeChild(IContext child)
	{
		final int childIndex = _children.indexOf(child);
		if (childIndex > -1)
		{
			_logger.info("Removing child context {0}", [child]);
    	_children.removeAt(childIndex);
    	child.injector.parentInjector = null;
    	//TODO: child.removeEventListener(LifecycleEvent.POST_DESTROY, onChildDestroy);
		}
		else
	  {
	  	_logger.warn("Child context {0} must be a child of {1}", [child, this]);
	  }
	  return this;
	}
	
	IContext addConfigHandler(IMatcher matcher, Function handler)
	{
		_configManager.addConfigHandler(matcher, handler);
  	return this;
	}
	
	ILogger getLogger(dynamic source)
	{
		return _logManager.getLogger(source);
	}

	IContext addLogTarget(ILogTarget target)
	{
		_logManager.addLogTarget(target);
  	return this;
	}
	
	IContext detain(List<dynamic> instances)
	{
		instances.forEach((dynamic instance) 
		{
			_pin.detain(instance);
		});
		return this;
	}

	IContext release(List<dynamic> instances)
	{
		instances.forEach((dynamic instance) 
		{
			_pin.release(instance);
		});
		return this;
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _setup()
	{
		_injector.map(IInjector).toValue(_injector);
		_injector.map(IContext).toValue(this);
		_logger = _logManager.getLogger(this);
		_pin = new Pin(this);
		_lifecycle = new Lifecycle(this);
		_configManager = new ConfigManager(this);
		_extensionInstaller = new ExtensionInstaller(this);
		beforeInitializing(beforeInitializingCallback);
		afterInitializing(afterInitializingCallback);
	  beforeDestroying(beforeDestroyingCallback);
	  afterDestroying(afterDestroyingCallback);
	}
	
	void beforeInitializingCallback()
	{
		_logger.info("Initializing...");
	}

	void afterInitializingCallback()
	{
		_logger.info("Initialize complete");
	}

	void beforeDestroyingCallback()
	{
		_logger.info("Destroying...");
	}

	void afterDestroyingCallback()
	{
		_pin.releaseAll();
	  _injector.teardown();
	  removeChildren();
	  _logger.info("Destroy complete");
	}
	
	//TODO: event stuff...
	/*void onChildDestroy(LifeCycleEvent event)
	{
		removeChild(event.target as IContext);
	}*/
	
	void removeChildren()
	{
		_children.forEach((IContext child)
		{
			removeChild(child);
		});
		_children.clear();
	}
}