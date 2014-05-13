part of robotlegs;

IMatcher instanceOfType(Type type)
{
	return new InstanceOfMatcher(type);
}

class InstanceOfMatcher implements IMatcher
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	Type _type;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	InstanceOfMatcher(this._type);

	//-----------------------------------
	//
	// Public Methods
	//
	//-----------------------------------
	
	bool matches(dynamic item)
	{
		return item.runtimeType == _type;
	}
}