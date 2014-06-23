part of robotlegs;

class ViewManager implements IViewManager
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	final List<dynamic> _containers = new List<dynamic>();
	List<dynamic> get containers => _containers;
	
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final List<IViewHandler> _handlers = new List<IViewHandler>();
	
	ContainerRegistry _registry;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	
	ViewManager(this._registry);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void addContainer(dynamic container)
	{
		if (!_validContainer(container))
			return;
		
		_containers.add(container);
		
		_handlers.forEach(
			(handler) {
			_registry.addContainer(container).addHandler(handler);
		});
		
		//dispatchEvent(new ViewManagerEvent(ViewManagerEvent.CONTAINER_ADD, container));
	}

	void removeContainer(dom.Element container)
	{
		if (!_containers.contains(container))
			return;
		
		_containers.remove(container);
		
		final ContainerBinding binding = _registry.getBinding(container);
		_handlers.forEach(
			(handler) {
			binding.removeHandler(handler);
		});
		
		//dispatchEvent(new ViewManagerEvent(ViewManagerEvent.CONTAINER_REMOVE, container));
	}
	
	void addViewHandler(IViewHandler handler)
	{
		if (_handlers.contains(handler))
			return;
		
		_handlers.add(handler);
		
		_containers.forEach(
			(container) {
			_registry.addContainer(container).addHandler(handler);
		});
		
		//dispatchEvent(new ViewManagerEvent(ViewManagerEvent.HANDLER_ADD, null, handler));
	}
	
	void removeViewHandler(IViewHandler handler)
	{
		if (!_handlers.contains(handler))
  			return;
		
		_handlers.remove(handler);
		
		_containers.forEach(
			(container) {
			_registry.getBinding(container).removeHandler(handler);
		});
		
		//dispatchEvent(new ViewManagerEvent(ViewManagerEvent.HANDLER_REMOVE, null, handler));
	}

	void removeAllHandlers()
	{
		_containers.forEach(
			(container) {
			final ContainerBinding binding = _registry.getBinding(container);
			
			_handlers.forEach(
				(handler){
				binding.removeHandler(handler);
			});
		});
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	bool _validContainer(dynamic container)
	{
		_containers.forEach(
			(registeredContainer) {
			
			if (container == registeredContainer)
				return false;
			
			if (registeredContainer.contains(container) || container.contains(registeredContainer)) 
				throw new Error();
		});
		return true;
	}
}