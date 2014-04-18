part of robotlegs;

class RobotlegsInjector extends Injector implements IInjector
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	set parent(IInjector value) => this.parentInjector = value;
	
	IInjector get parent => this.parentInjector;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	IInjector createChild()
	{
		final IInjector childInjector = new RobotlegsInjector();
		childInjector.parentInjector = this;
		return childInjector;
	}
}