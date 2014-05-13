part of robotlegs;

class TypeMatcherError extends Error
{
	
	static const String EMPTY_MATCHER = "An empty matcher will create a filter which matches nothing. You should specify at least one condition for the filter.";

	static const String SEALED_MATCHER = "This matcher has been sealed and can no longer be configured.";
	
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
	
	TypeMatcherError([this.message = ""]);
      
	//-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
  String toString() 
  {
    if (message != null) 
      return "TypeMatcherError: $message";

    return "TypeMatcherError";
  }
}