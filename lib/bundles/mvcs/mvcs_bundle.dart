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
				ViewManagerExtension,
				ViewProcessorMapExtension,
				StageCrawlerExtension,
				StageSyncExtension,
				MessageCommandMapExtension,
				MediatorMapExtension]);
		
		context.configure([ContextViewListenerConfig]);
	}
}