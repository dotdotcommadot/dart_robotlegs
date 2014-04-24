part of robotlegs;

class ExtensionInstaller
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	Map<Type, bool> _classes = new Map<Type, bool>();
	
	Reflector _reflector = new Reflector();
	
	IContext _context;
	
	ILogger _logger;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	ExtensionInstaller(this._context)
	{
		_logger = _context.getLogger(this);
	}
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void install(dynamic extension)
	{
		if (extension is Type)
		{
			if (_classes[extension] == null) 
				install(reflectClass(extension).newInstance(new Symbol(''), []).reflectee);
		}
		else
		{
			final Type extensionsClass = _reflector.getType(extension);
			if (_classes[extensionsClass] != null)
				return
			_logger.debug("Installing extension {0}", [extension]);
			_classes[extensionsClass] = true;
			extension.extend(_context);
		}
	}
}