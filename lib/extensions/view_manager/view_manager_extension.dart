part of robotlegs;

class ViewManagerExtension implements IExtension
{
  //-----------------------------------
  //
  // Private Static Properties
  //
  //-----------------------------------
	
	static ContainerRegistry _containerRegistry;
	
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IInjector _injector;
	
	IViewManager _viewManager;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		context.whenInitializing(_whenInitializing);
	  context.whenDestroying(_whenDestroying);
	
	  _injector = context.injector;
	  
	  if (_containerRegistry == null)
	  	_containerRegistry = new ContainerRegistry();
	  
  	_injector.map(ContainerRegistry).toValue(_containerRegistry);
  	
  	_injector.map(IViewManager).toSingleton(ViewManager);
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _whenInitializing()
	{
		_viewManager = _injector.getInstance(IViewManager);
	}

	void _whenDestroying()
	{
		_viewManager.removeAllHandlers();
		_injector.unmap(IViewManager);
		_injector.unmap(ContainerRegistry);
	}
}