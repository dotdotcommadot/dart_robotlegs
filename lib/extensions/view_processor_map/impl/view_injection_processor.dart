part of robotlegs;

class ViewInjectionProcessor
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final Map _injectedObjects = new Map();
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void process(dynamic view, Type type, IInjector injector)
	{
		if (_injectedObjects[view] == null)
			_injectAndRemember(view, injector);
	}

	void unprocess(dynamic view, Type type, IInjector injector)
	{
		
	}
	
	void _injectAndRemember(dynamic view, IInjector injector)
	{
		injector.injectInto(view);
  	_injectedObjects[view] = view;
	}
}