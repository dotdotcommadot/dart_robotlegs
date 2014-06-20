part of robotlegs;

abstract class IMessageCommandMap
{
	ICommandMapper map(Symbol name);

	ICommandUnmapper unmap(Symbol name);
	
	IMessageCommandMap addMappingProcessor(Function handler);
}