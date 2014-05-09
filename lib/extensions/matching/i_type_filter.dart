part of robotlegs;

abstract class ITypeFilter extends IMatcher
{
	List<Type> get allOfTypes;

	List<Type> get anyOfTypes;

	List<Type> get noneOfTypes;
	
	String get descriptor;
}