part of robotlegs;

abstract class IMessageCommandMap
{
	ICommandMapper map(Symbol name, Type messageType);

	ICommandUnmapper unmap(Symbol name, Type messageType);
	
	IMessageCommandMap addMappingProcessor(Function handler);
}