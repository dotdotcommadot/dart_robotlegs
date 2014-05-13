part of robotlegs;

class ContainerRegistry
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	final List<ContainerBinding> _bindings = new List<ContainerBinding>();
	
	List<ContainerBinding> get bindings => _bindings;
	
	final List<ContainerBinding> _rootBindings = new List<ContainerBinding>();

	List<ContainerBinding> get rootBindings => _rootBindings;
	
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final Map<dynamic, ContainerBinding> _bindingsByContainer = new Map<dynamic, ContainerBinding>();
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	ContainerBinding addContainer(dynamic container)
	{
		if (_bindingsByContainer[container] == null)
			return _createBinding(container);
		else
			return _bindingsByContainer[container];
	}

	ContainerBinding removeContainer(dynamic container)
	{
		final ContainerBinding binding = _bindingsByContainer[container];
		if (binding != null)
			_removeBinding(binding);
		return binding;
	}

	ContainerBinding findParentBinding(dynamic target)
	{
		dynamic parent = target.parent;
		while (parent != null)
		{
			ContainerBinding binding = _bindingsByContainer[parent];
			if (binding != null)
			{
				return binding;
			}
			parent = parent.parent;
		}
		return null;
	}

	ContainerBinding getBinding(dynamic container)
	{
		return _bindingsByContainer[container];
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	ContainerBinding _createBinding(dynamic container)
	{
		final ContainerBinding binding = new ContainerBinding(container);
		_bindings.add(binding);
		
		//binding.addEventListener(ContainerBindingEvent.BINDING_EMPTY, _onBindingEmpty);
		
		binding.parent = findParentBinding(container);
		if (binding.parent == null)
		{
			_addRootBinding(binding);
		}
		
		_bindingsByContainer.forEach( 
			(key, childBinding) {
			
			if (container.contains(childBinding.container))
			{
				if (childBinding.parent == null)
				{
					_removeRootBinding(childBinding);
					childBinding.parent = bindings;
				}
				else if (container.contains(childBinding.parent.container))
				{
					childBinding.parent = bindings;
				}
			}
		});
		
		//dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.CONTAINER_ADD, binding.container));
		return binding;
	}
	
	void _removeBinding(ContainerBinding binding)
	{
		_bindingsByContainer.remove(binding.container);
		_bindings.remove(binding);
		
		//binding.removeEventListener(ContainerBindingEvent.BINDING_EMPTY, _onBindingEmpty);
		
		if (binding.parent == null)
		{
			_removeRootBinding(binding);
		}
		
		_bindingsByContainer.forEach( 
			(key, childBinding) {
			
			if (childBinding.parent == binding)
			{
				childBinding.parent = binding.parent;
				if (childBinding.parent == null)
				{
					_addRootBinding(childBinding);
				}
			}
		});
		
		//dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.CONTAINER_REMOVE, binding.container));
	}

	void _addRootBinding(dynamic binding)
	{
		_rootBindings.add(binding);
		//dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.ROOT_CONTAINER_ADD, binding.container));
	}
	
	void _removeRootBinding(dynamic binding)
	{
		_rootBindings.remove(binding);
		//dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.ROOT_CONTAINER_REMOVE, binding.container));
	}

	void _onBindingEmpty(dynamic binding)
	{
		_removeBinding(binding as ContainerBinding);
	}
}