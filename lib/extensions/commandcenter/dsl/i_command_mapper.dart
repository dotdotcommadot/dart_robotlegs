part of robotlegs;

abstract class ICommandMapper
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
  ICommandConfigurator toCommand(Type commandClass);
}