part of robotlegs;

abstract class IViewProcessorMapping
{
	ITypeFilter get matcher;

	dynamic get processor;

	void set processor(value);

	Type get processorType;
	
	List get guards;

	List get hooks;
}