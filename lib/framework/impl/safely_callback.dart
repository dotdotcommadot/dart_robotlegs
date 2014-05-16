part of robotlegs;

void safelyCallback(Function callback, [dynamic error = null, dynamic message = null])
{
	InstanceMirror mirror = reflect(callback);
	
	if ((mirror.type as FunctionTypeMirror).parameters.length == 0)
	{
		callback();
	}
	else if ((mirror.type as FunctionTypeMirror).parameters.length == 1)
	{
		callback(error);
	}
	else
	{
		callback(error, message);
	}
	 
	 
	
	
	
	
	//Function.apply(callback, [error, message]);
}