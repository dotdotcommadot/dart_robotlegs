part of robotlegs;

class StageObserverExtension implements IExtension
{
  //-----------------------------------
  //
  // Private Static Properties
  //
  //-----------------------------------
	
	static StageObserver _stageObserver;

	static int _installCount;
	
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IInjector _injector;
	
	ILogger _logger;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		context.whenInitializing(_whenInitializing);
  	context.whenDestroying(_whenDestroying);
  	_installCount++;
  	_injector = context.injector;
  	_logger = context.getLogger(this);
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _whenInitializing()
	{
		if (_stageObserver == null)
		{
			final ContainerRegistry containerRegistry = _injector.getInstance(ContainerRegistry);
			_logger.debug("Creating genuine StageObserver Singleton");
			_stageObserver = new StageObserver(containerRegistry);
		}
	}
	
	void _whenDestroying()
	{
		_installCount --;
		if (_installCount == 0)
	  {
		  _logger.debug("Destroying genuine StageObserver Singleton");
		  _stageObserver.destroy();
		  _stageObserver = null;
	  }
	}
}