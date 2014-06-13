part of robotlegs;

void applyHooks(List<dynamic> hooks, [IInjector injector = null]) 
{
	hooks.forEach( (dynamic hook)
	{
		if (hook is Function)
		{
			Function.apply(hook, []);
		}
		if (hook is Type)
		{
			hook = (injector == null)
							? injector.instantiateUnmapped(hook as Type)
		      		: reflectClass(hook as Type).newInstance(new Symbol(''), []);
		}
		hook.hook();
	});
}