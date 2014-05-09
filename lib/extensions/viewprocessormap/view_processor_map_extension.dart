part of robotlegs;

class ViewProcessorMapExtension implements IExtension
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IInjector _injector;
	
	IViewProcessorMap _viewProcessorMap;
	
	IViewManager _viewManager;
	
	IViewProcessorFactory _viewProcessorFactory;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		context.beforeInitializing(_beforeInitializing);
		context.beforeDestroying(_beforeDestroying);
	  context.whenDestroying(_whenDestroying);
	  _injector = context.injector;
	  _injector.map(IViewProcessorFactory).toValue(new ViewProcessorFactory(_injector.createChildInjector()));
	  _injector.map(IViewProcessorMap).toSingleton(ViewProcessorMap);
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _beforeInitializing()
	{
		_viewProcessorMap = _injector.getInstance(IViewProcessorMap);
	  _viewProcessorFactory = _injector.getInstance(IViewProcessorFactory);
	  
	  if (_injector.satisfiesDirectly(IViewManager))
	  {
		  _viewManager = _injector.getInstance(IViewManager);
		  _viewManager.addViewHandler(_viewProcessorMap as IViewHandler);
	  }
	}
	
	void _beforeDestroying()
	{
		_viewProcessorFactory.runAllUnprocessors();

	  if (_injector.satisfiesDirectly(IViewManager))
	  {
		  _viewManager = _injector.getInstance(IViewManager);
		  _viewManager.removeViewHandler(_viewProcessorMap as IViewHandler);
	  }
	}
	
	void _whenDestroying()
	{
		if (_injector.satisfiesDirectly(IViewProcessorMap))
	  {
	  	_injector.unmap(IViewProcessorMap);
	  }
	  if (_injector.satisfiesDirectly(IViewProcessorFactory))
	  {
	  	_injector.unmap(IViewProcessorFactory);
	  }
	}
}