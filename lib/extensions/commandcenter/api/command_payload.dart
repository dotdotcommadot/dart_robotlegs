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
  
  List _classes;
  List get classes => _classes;
  
  int get length => (_classes != null) ? _classes.length : 0;
  
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
  
  CommandPayload(this._values,this._classes);
  
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
  
  CommandPayload addPayload(dynamic payloadValue, Type payloadClass)
  {
    if (_values != null)
    {
    	_values.add(payloadValue);
    }
    else
    {
    	_values = [payloadValue];
    }
    if (_classes != null)
    {
    	_classes.add(payloadClass);
    }
    else
    {
    	_classes = [payloadClass];
    }
    
    return this;
  }

  bool hasPayload()
  {
    return (_values != null && _values.length > 0) 
    		&& (classes != null && _classes.length == _values.length);
  }
}