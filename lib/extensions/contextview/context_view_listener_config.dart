part of robotlegs;

class ContextViewListenerConfig implements IConfig
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	@inject
	ContextView contextView;
	
	@inject
	IViewManager viewManager;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void configure()
	{
		viewManager.addContainer(contextView.view);
	}
}