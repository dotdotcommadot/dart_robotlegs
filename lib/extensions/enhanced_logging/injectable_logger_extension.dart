part of robotlegs;

class InjectableLoggerExtension implements IExtension
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		context.injector.map(ILogger).toProvider(new LoggerProvider(context));
	}
}