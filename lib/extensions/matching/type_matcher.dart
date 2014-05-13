part of robotlegs;

class TypeMatcher implements ITypeMatcher, ITypeMatcherFactory
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	List<Type> _allOfTypes = new List<Type>();

	List<Type> _anyOfTypes = new List<Type>();

	List<Type> _noneOfTypes = new List<Type>();
	
	ITypeFilter _typeFilter;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	TypeMatcher allOf(List<Type> types)
	{
		_pushAddedTypesTo(types, _allOfTypes);
		return this;
	}

	TypeMatcher anyOf(List<Type> types)
	{
		_pushAddedTypesTo(types, _anyOfTypes);
		return this;
	}

	TypeMatcher noneOf(List<Type> types)
	{
		_pushAddedTypesTo(types, _noneOfTypes);
		return this;
	}

	ITypeFilter createTypeFilter()
	{
		if (_typeFilter == null)
			_typeFilter = _buildTypeFilter();
		
		return _typeFilter;
	}

	ITypeMatcherFactory lock()
	{
		createTypeFilter();
  	return this;
	}
	
	TypeMatcher clone()
	{
		return new TypeMatcher().allOf(_allOfTypes).anyOf(_anyOfTypes).noneOf(_noneOfTypes);
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	ITypeFilter _buildTypeFilter()
	{
		if ((_allOfTypes.length == 0) &&
				(_anyOfTypes.length == 0) &&
				(_noneOfTypes.length == 0))
		{
			throw new TypeMatcherError(TypeMatcherError.EMPTY_MATCHER);
		}
		
		return new TypeFilter(_allOfTypes, _anyOfTypes, _noneOfTypes);
	}
	
	void _pushAddedTypesTo(List<Type> types, List<Type> targetSet)
	{
		if (_typeFilter != null)
			_throwSealedMatcherError();
		
		_pushValuesToClassVector(types, targetSet);
	}
	
	void _throwSealedMatcherError()
	{
		throw new TypeMatcherError(TypeMatcherError.SEALED_MATCHER);
	}
	
	// TODO: probably not neccesary in Dart
	void _pushValuesToClassVector(List values, List<Type> vector)
	{
		if (values.length == 1 &&
				values[0] is List ||
				values[0] is List<Type>)
		{
			values[0].forEach( (type) {
				vector.add(type);
			});
		}
		else
		{
			values.forEach( (type) {
				vector.add(type);
			});
		}
	}
}