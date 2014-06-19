part of robotlegs;

class ContainerBinding
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	ContainerBinding _parent;
	ContainerBinding get parent => _parent;
	set parent(value) => _parent = value;

	dom.Element _container;
	dom.Element get container => _container;
	
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final List<IViewHandler> _handlers = new List<IViewHandler>();
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

	ContainerBinding(_container);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void addHandler(IViewHandler handler)
	{
		if (_handlers.contains(handler))
			return;
		
		_handlers.add(handler);
	}

	void removeHandler(IViewHandler handler)
	{
		if (_handlers.contains(handler))
		{
			_handlers.remove(handler);
			
			// TODO
			/*if (_handlers.length == 0)
				dispatchEvent(new ContainerBindingEvent(ContainerBindingEvent.BINDING_EMPTY));*/
		}
	}
	
	void handleView(dom.Element view, Type type)
	{
		final int length = _handlers.length;
		
		for (int i = 0; i < length; i++)
		{
			IViewHandler handler = _handlers[i];
			handler.handleView(view, type);
		}
	}
	
}