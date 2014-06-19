part of robotlegs;

class MediatorMapExtension implements IExtension
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IInjector _injector;
	
	MediatorMap _mediatorMap;
	
	IViewManager _viewManager;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		context.beforeInitializing(_beforeInitializing)
				   .beforeDestroying(_beforeDestroying)
				   .whenDestroying(_whenDestroying);
		
		_injector = context.injector;
		_injector.map(IMediatorMap).toSingleton(MediatorMap);
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _beforeInitializing()
	{
		_mediatorMap = _injector.getInstance(IMediatorMap);
		if (_injector.satisfiesDirectly(IViewManager))
		{
			_viewManager = _injector.getInstance(IViewManager);
			_viewManager.addViewHandler(_mediatorMap);
		}
	}
	
	void _beforeDestroying()
	{
		_mediatorMap.unmediateAll();
		if (_injector.satisfiesDirectly(IViewManager))
	  {
		  _viewManager = _injector.getInstance(IViewManager);
		  _viewManager.removeViewHandler(_mediatorMap);
	  }
	}
	
	void _whenDestroying()
	{
		if (_injector.satisfiesDirectly(IMediatorMap))
		{
			_injector.unmap(IMediatorMap);
		}
	}
}