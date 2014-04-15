part of robotlegs;

void safelyCallback(Function callback, [dynamic error = null, dynamic message = null])
{
	Function.apply(callback, [error, message]);
}