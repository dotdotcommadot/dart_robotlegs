part of robotlegs;

class PrintLoggingExtension implements IExtension
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		context.addLogTarget(new PrintLogTarget(context));
	}
}