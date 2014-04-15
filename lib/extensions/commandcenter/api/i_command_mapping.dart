part of robotlegs;

abstract class ICommandMapping
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
  Type get commandType;
  
  Symbol get executeMethod;
  
  List<IGuard> get guards;
  
  List<IHook> get hooks;
  
  bool get fireOnce;
  
  bool get payloadInjectionEnabled;
  
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
  
  ICommandMapping setExecuteMethod(Symbol name);
  
  ICommandMapping addGuards(List<IGuard> guards);
  
  ICommandMapping addHooks(List<IHook> hooks);
  
  ICommandMapping setFireOnce(bool value);
  
  ICommandMapping setPayloadInjectionEnabled(bool value);
}