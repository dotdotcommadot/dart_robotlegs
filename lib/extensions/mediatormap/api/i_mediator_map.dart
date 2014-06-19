part of robotlegs;

abstract class IMediatorMap
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	IMediatorMapper mapMatcher(ITypeMatcher matcher);

	IMediatorMapper map(Type type);

	IMediatorUnmapper unmapMatcher(ITypeMatcher matcher);

	IMediatorUnmapper unmap(Type type);

	void mediate(dynamic item);

	void unmediate(dynamic item);

	void unmediateAll();
}