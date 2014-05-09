part of robotlegs;

abstract class IViewProcessorFactory
{
	void runProcessors(dynamic view, Type type, List<IViewProcessorMapping> processorMappings);

	void runUnprocessors(dynamic view, Type type, List<IViewProcessorMapping> processorMappings);
	
	void runAllUnprocessors();
}