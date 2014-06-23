part of robotlegs;

abstract class IMediatorConfigurator
{
	IMediatorConfigurator withGuards(List guards);

	IMediatorConfigurator withHooks(List hooks);

	IMediatorConfigurator autoRemove([bool value = true]);
}