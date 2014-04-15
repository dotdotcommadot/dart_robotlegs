part of robotlegs;

abstract class ICommandConfigurator
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
  ICommandConfigurator withExecuteMethod(Symbol method);
  
  ICommandConfigurator withGuards(List<IGuard> guards);
  
  ICommandConfigurator withHooks(List<IHook> hooks);
  
  ICommandConfigurator once([bool value = true]);
  
  ICommandConfigurator withPayloadInjection([bool value = true]);
}