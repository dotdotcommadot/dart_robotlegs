part of robotlegs;

class ContainerBinding extends Object with MessagingMixin
{
  //-----------------------------------
  //
  // Public Static Properties
  //
  //-----------------------------------
	
  //-----------------------------------
  // Messages
  //-----------------------------------
	
	static const Symbol BINDING_EMPTY = const Symbol('ContainerBinding.BINDING_EMPTY');
	
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
			
			if (_handlers.length == 0)
				sendMessage(ContainerBinding.BINDING_EMPTY);
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