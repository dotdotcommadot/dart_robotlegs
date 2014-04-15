part of robotlegs;

abstract class ICommandUnmapper
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
  void fromCommand( Type commandClass );
  
  void fromAll();
}