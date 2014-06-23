part of robotlegs;

abstract class IViewProcessorViewHandler {
	
	void addMapping(IViewProcessorMapping mapping);

	void removeMapping(IViewProcessorMapping mapping);

	void processItem(dynamic item, Type type);

	void unprocessItem(dynamic item, Type type);
}