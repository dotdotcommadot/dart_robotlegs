part of robotlegs;

abstract class IMediatorMapping
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	ITypeFilter get matcher;

	Type get mediatorType;

	List get guards ;

	List get hooks ;

	bool get autoRemoveEnabled ;
}