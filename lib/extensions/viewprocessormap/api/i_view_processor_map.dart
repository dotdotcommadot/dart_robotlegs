part of robotlegs;

abstract class IViewProcessorMap
{
	IViewProcessorMapper mapMatcher(ITypeMatcher matcher);

	IViewProcessorMapper map(Type type);

	IViewProcessorUnmapper unmapMatcher(ITypeMatcher matcher);

	IViewProcessorUnmapper unmap(Type type);
	
	void process(dynamic item);

	void unprocess(dynamic item);
}