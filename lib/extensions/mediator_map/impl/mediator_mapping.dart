part of robotlegs;

class MediatorMapping implements IMediatorMapping, IMediatorConfigurator
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	ITypeFilter _matcher;
	ITypeFilter get matcher => _matcher;
	
	Type _mediatorType;
	Type get mediatorType => _mediatorType;

	List _guards = [];
	List get guards => _guards;

	List _hooks = [];
	List get hooks => _hooks;
	
	bool _autoRemoveEnabled = true;
	bool get autoRemoveEnabled => _autoRemoveEnabled;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	MediatorMapping(this._matcher, this._mediatorType);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	IMediatorConfigurator withGuards(List guards)
	{
		_guards.addAll(guards);
		return this;
	}

	IMediatorConfigurator withHooks(List hooks)
	{
		_hooks.addAll(hooks);
		return this;
	}
	
	IMediatorConfigurator autoRemove([bool value = true])
	{
		_autoRemoveEnabled = value;
  	return this;
	}
}