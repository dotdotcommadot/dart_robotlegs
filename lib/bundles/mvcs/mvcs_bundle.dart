part of robotlegs;

class MVCSBundle implements IBundle 
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend( IContext context ) 
	{
		context.logLevel = LogLevel.DEBUG;
		
		context.install(
				[ContextViewExtension,
				 PrintLoggingExtension,
				 ViewManagerExtension,
				 ViewProcessorMapExtension,
				 StageCrawlerExtension,
				 StageSyncExtension,
				 MessageDispatcherExtension,
				 MessageCommandMapExtension,
				 MediatorMapExtension]);
		
		context.configure([ContextViewListenerConfig]);
	}
}