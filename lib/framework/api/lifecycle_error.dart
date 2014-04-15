part of robotlegs;

class LifecycleError extends Error {
	
  //-----------------------------------
  //
  // Public Static Properties
  //
  //-----------------------------------
	
	static const String SYNC_HANDLER_ARG_MISMATCH = "When and After handlers must accept 0 or 1 arguments";

	static const String LATE_HANDLER_ERROR_MESSAGE = "Handler added late and will never fire";
	
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	final String message;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	LifecycleError(this.message);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	String toString() 
	{
  	return message;
  }
}