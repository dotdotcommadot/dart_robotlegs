part of robotlegs;

class ViewProcessorMapping implements IViewProcessorMapping, IViewProcessorMappingConfig
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	ITypeFilter _matcher;
	ITypeFilter get matcher => _matcher;

	dynamic _processor;
	dynamic get processor => _processor;
	set processor(value) => _processor = value;

	Type _processorType;
	Type get processorType => _processorType;
	
	List _guards;
	List get guards => _guards;
	
	List _hooks;
	List get hooks => _hooks;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	ViewProcessorMapping(this._matcher, this._processor);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	IViewProcessorMappingConfig withGuards(List guards)
	{
		_guards = guards;
		return this;
	}

	IViewProcessorMappingConfig withHooks(List hooks)
	{
		_hooks = hooks;
		return this;
	}
	
	String toString()
	{
		return 'Processor ' + _processor;
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void setProcessor(dynamic processor)
	{
		if (processor is Type)
		{
			_processorType = processor as Type;
		}
		else
		{
			_processor = processor;
			_processorType = _processor.runtimeType;
		}
	}
}