part of robotlegs;

class LogMessageParser
{
	String parseMessage(String message, List<dynamic> params)
	{
		if (params != null && params.length > 0)
		{
			final int numParams = params.length;
			for (int i = 0; i < numParams; i++)
			{
				if (params[i] is Type)
					message = message.split("{" + i.toString() + "}").join(params[i].toString());
				else
					message = message.split("{" + i.toString() + "}").join(params[i].runtimeType.toString());
					
			}
		}
		
		return message;
	}
}