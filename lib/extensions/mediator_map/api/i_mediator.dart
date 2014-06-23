part of robotlegs;

abstract class IMediator 
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	dynamic viewComponent;
	
	void preInitialize();

	void initialize();

	void postInitialize();

	void preDestroy();
	
	void destroy();

	void postDestroy();
}