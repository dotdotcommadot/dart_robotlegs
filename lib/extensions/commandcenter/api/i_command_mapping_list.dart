part of robotlegs;

abstract class ICommandMappingList
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
  ICommandMappingList withSortFunction(Function sorter);
  
  List<ICommandMapping> getList();
  
  void addMapping(ICommandMapping mapping);
  
  void removeMapping(ICommandMapping mapping);
  
  void removeMappingFor(Type commandType);
  
  void removeAllMappings();
}