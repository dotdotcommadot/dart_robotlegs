part of robotlegs;

class CommandPayload
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
  
  List _values;
  List get values => _values;
  
  List<Type> _types;
  List<Type> get types => _types;
  
  int get length => (_types != null) ? _types.length : 0;
  
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
  
  CommandPayload(this._values,this._types);
  
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
  
  CommandPayload addPayload(dynamic payloadValue, Type payloadType)
  {
    if (_values != null)
    {
    	_values.add(payloadValue);
    }
    else
    {
    	_values = [payloadValue];
    }
    if (_types != null)
    {
    	_types.add(payloadType);
    }
    else
    {
    	_types = [payloadType];
    }
    
    return this;
  }

  bool hasPayload()
  {
    return (_values != null && _values.length > 0) 
    		&& (types != null && _types.length == _values.length);
  }
}