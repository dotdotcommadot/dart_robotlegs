part of robotlegs;

void safelyCallback(Function callback, [dynamic error = null, dynamic message = null])
{
	ClosureMirror mirror = reflect(callback);
	
	if (mirror.function.parameters.length == 0)
	{
		callback();
	}
	else if (mirror.function.parameters.length == 1)
	{
		callback(error);
	}
	else
	{
		callback(error, message);
	}
}