part of robotlegs;

class StageObserver
{
  //-----------------------------------
  //
  // Private Static Properties
  //
  //-----------------------------------
	
	ContainerRegistry _registry;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	StageObserver(this._registry)
	{
		_registry.addMessageListener(ContainerRegistry.ROOT_CONTAINER_ADD, _onRootContainerAdd);
		_registry.addMessageListener(ContainerRegistry.ROOT_CONTAINER_REMOVE, _onRootContainerRemove);
		
		_registry.rootBindings.forEach((binding) => _addRootListener(binding.container));
	}
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void destroy()
	{
		_registry.removeMessageListener(ContainerRegistry.ROOT_CONTAINER_ADD, _onRootContainerAdd);
		_registry.removeMessageListener(ContainerRegistry.ROOT_CONTAINER_REMOVE, _onRootContainerRemove);
		
		_registry.rootBindings.forEach((binding) => _removeRootListener(binding.container));
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _onRootContainerAdd(Message message)
	{
		_addRootListener(message.data as dom.Element);
	}

	void _onRootContainerRemove(Message message)
	{
		_removeRootListener(message.data as dom.Element);
	}
	
	void _addRootListener(dom.Element container)
	{
		///////////// container.
	}

	void _removeRootListener(dom.Element container)
	{
		///////////// container.
	}
	
	void onViewAddedToDom()
	{
		
	}
	
	void onContainerRootAddedToStage()
	{
		
	}
}