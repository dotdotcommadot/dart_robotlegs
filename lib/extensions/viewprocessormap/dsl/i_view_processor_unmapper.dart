part of robotlegs;

abstract class IViewProcessorUnmapper
{
	void fromProcess(dynamic processorClassOrInstance);
	
	void fromNoProcess();
	
	void fromInjection();
	
	void fromAll();
}