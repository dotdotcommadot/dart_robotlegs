part of robotlegs;

bool guardsApprove(List<dynamic> guards, [IInjector injector = null]) 
{
	guards.forEach( (dynamic guard)
	{
		if (guard is Function)
		{
			if( Function.apply(guard, []) == null )
				return false;
		}
		if (guard is Type)
		{
			guard = (injector == null)
							? injector.instantiateUnmapped(guard as Type)
		      		: reflectClass(guard as Type).newInstance(new Symbol(''), []);
		}
		if(guard.approve() == false)
			return false;
	});
	return true;
}