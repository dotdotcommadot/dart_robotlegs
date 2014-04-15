part of robotlegs;

class Pin 
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final Map<dynamic, bool> _instances = new Map<dynamic, bool>();
	
	// TODO: replace with eventdesipatcher equivalent
	dynamic _dispatcher;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	Pin(this._dispatcher);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void detain(dynamic instance)
	{
		if (_instances[instance] == null)
		{
			_instances[instance] = true;
			//_dispatcher.dispatchEvent()
		}
	}
	
	void release(dynamic instance)
	{
		if (_instances[instance] != null)
		{
			_instances.remove(instance);
			//_dispatcher.dispatchEvent()
		}
	}
	
	void releaseAll()
	{
		_instances.forEach( (dynamic instance, bool pinned) => release(instance));
	}
}