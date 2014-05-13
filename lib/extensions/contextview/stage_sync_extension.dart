part of robotlegs;

class StageSyncExtension implements IExtension
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IContext _context;
	
	Element _contextView;
	
	ILogger _logger;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		_context = context;
		_logger = context.getLogger(this);
		_context.addConfigHandler(
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
		if (_contextView != null)
		{
			_logger.warn('A contextView has already been installed, ignoring {0}', [contextView.view]);
    	return;
		}
		
		_contextView = contextView.view;
		
		if (_contextView.parent != null)
		{
			_initializeContext();
		}
		else
		{
			_logger.debug("Context view is not yet on stage. Waiting...");
			//_contextView.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
	}
	
	void _onAddedToStage()
	{
		//_contextView.removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
  	_initializeContext();
	}
	
	void _initializeContext()
	{
		_logger.debug("Context view is now on stage. Initializing context...");
	  _context.initialize();
	  //_contextView.addEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);
	}
	
	void _onRemovedFromStage()
	{
		_logger.debug("Context view has left the stage. Destroying context...");
	 // _contextView.removeEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);
	  _context.destroy();
	}
}