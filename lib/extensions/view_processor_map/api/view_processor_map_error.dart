part of robotlegs;

class ViewProcessorMapError extends Error
{
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
	
	ViewProcessorMapError([this.message = ""]);
      
	//-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
  String toString() 
  {
    if (message != null) 
      return "ViewProcessorMapError: $message";

    return "ViewProcessorMapError";
  }
}