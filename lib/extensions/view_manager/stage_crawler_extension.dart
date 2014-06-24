part of robotlegs;

class StageCrawlerExtension
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	ILogger _logger;
	
	IInjector _injector;
	
	ContainerRegistry _containerRegistry;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		_injector = context.injector;
    _logger = context.getLogger(this);
    context.afterInitializing(_afterInitializing);
	}
	
	//-----------------------------------
	//
	// Private Methods
	//
	//-----------------------------------
	
	void _afterInitializing()
	{
		_containerRegistry = _injector.getInstance(ContainerRegistry);
		_injector.hasDirectMapping(IViewManager) 
			? _scanViewManagedContainers()
	    : _scanContextView();
	}
	
	void _scanViewManagedContainers()
	{
		_logger.debug("ViewManager is installed. Checking for managed containers...");
		final IViewManager viewManager = _injector.getInstance(IViewManager);
		viewManager.containers.forEach((container) {
			// TODO
			if (container != null)
				_scanContainer(container);
		});
	}
	
	void _scanContextView()
	{
		_logger.debug("ViewManager is not installed. Checking the ContextView...");
		ContextView contextView = _injector.getInstance(ContextView);
		// TODO
		if (contextView.view != null)
			_scanContainer(contextView.view);
	}
	
	void _scanContainer(dynamic container)
	{
		ContainerBinding binding = _containerRegistry.getBinding(container);
		_logger.debug("StageCrawler scanning container {0} ...", [container]);
		new StageCrawler(binding).scan(container);
		_logger.debug("StageCrawler finished scanning {0}", [container]);
	}
	
}