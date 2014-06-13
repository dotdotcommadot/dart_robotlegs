part of robotlegs;

class TypeFilter implements ITypeFilter
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	List<Type> _allOfTypes;
	List<Type> get allOfTypes => _allOfTypes;

	List<Type> _anyOfTypes;
	List<Type> get anyOfTypes => _anyOfTypes;

	List<Type> _noneOfTypes;
	List<Type> get noneOfTypes => _noneOfTypes;
	
	String _descriptor;
	String get descriptor => _descriptor != null ? _descriptor : _createDescriptor();
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	TypeFilter(this._allOfTypes, this._anyOfTypes, this._noneOfTypes)
	{
		if (_allOfTypes == null || _anyOfTypes == null || _noneOfTypes == null)
  		throw new ArgumentError('TypeFilter parameters can not be null');
	}
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	bool matches(dynamic item)
	{
		int i = _allOfTypes.length;
		
		while (i > 0)
		{
			i--;
			
			if (!(item.runtimeType == _allOfTypes[i]))
			{
				return false;
			}
		}
		
		i = _noneOfTypes.length;
		
		while (i > 0)
		{
			i--;
			
			if (item.runtimeType == _noneOfTypes[i])
			{
				return false;
			}
		}
		
		if (_anyOfTypes.length == 0 && (_allOfTypes.length > 0 || _noneOfTypes.length > 0))
	  {
	  	return true;
	  }
		
		i = _anyOfTypes.length;
		
		while (i > 0)
		{
			i--;
			
			if (item.runtimeType == _anyOfTypes[i])
			{
				return true;
			}
		}
		
		return false;
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	String _createDescriptor()
	{
		final List<String> allOf_FCQNs 	= _alphabetiseCaseInsensitiveFCQNs(allOfTypes);
		final List<String> anyOf_FCQNs 	= _alphabetiseCaseInsensitiveFCQNs(anyOfTypes);
		final List<String> noneOf_FCQNs = _alphabetiseCaseInsensitiveFCQNs(noneOfTypes);
		
		return "all of: " + allOf_FCQNs.toString()
		  + ", any of: " + anyOf_FCQNs.toString()
		  + ", none of: " + noneOf_FCQNs.toString();
	}
	
	List<String> _alphabetiseCaseInsensitiveFCQNs(List<Type> types)
	{
		String fqcn;
		List<String> allFCQNs = new List<String>();
		
		final int iLength = types.length;
		for (int i = 0; i < iLength; i++)
		{
			fqcn = types[i].toString();
			allFCQNs.add(fqcn);
		}
		
		allFCQNs.sort((a, b) => a.compareTo(b));
		return allFCQNs;
	}
}