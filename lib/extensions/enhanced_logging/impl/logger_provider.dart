part of robotlegs;

class LoggerProvider implements IProvider
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IContext _context;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	LoggerProvider(this._context);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	 dynamic apply(IInjector injector, Type type, Map injectParameters)
	 {
		 return _context.getLogger(type);
	 }
   
   void destroy()
   {
  	 
   }
}
