part of robotlegs;

abstract class IViewProcessorMapper
{
	IViewProcessorMappingConfig toProcess(dynamic processClassOrInstance);

	IViewProcessorMappingConfig toInjection();

	IViewProcessorMappingConfig toNoProcess();
}