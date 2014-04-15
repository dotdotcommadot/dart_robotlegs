part of robotlegs;

abstract class ICommandExecutor
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
  void executeCommand(ICommandMapping mapping, [CommandPayload payload = null]);
  
  void executeCommands(List<ICommandMapping> mappings, [CommandPayload payload = null]);
}