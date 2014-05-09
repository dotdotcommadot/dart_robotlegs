part of robotlegs;

class ContextViewExtension implements IExtension
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IInjector _injector;
	
	ILogger _logger;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		_injector = context.injector;
		_logger = context.getLogger(this);
		context.beforeInitializing(_beforeInitializing);
		context.addConfigHandler(
			instanceOfType(ContextView), 
			_handleContextView);
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _handleContextView(ContextView contextView)
	{
		if (_injector.hasDirectMapping(ContextView))
		{
			_logger.warn('A contextView has already been installed, ignoring {0}', [contextView.view]);
		}
		else
		{
			_logger.debug("Mapping {0} as contextView", [contextView.view]);
    	_injector.map(ContextView).toValue(contextView);
		}
	}
	
	void _beforeInitializing()
	{
		if (!_injector.hasDirectMapping(ContextView))
		{
			_logger.error("A ContextView must be installed if you install the ContextViewExtension.");
		}
	}
}