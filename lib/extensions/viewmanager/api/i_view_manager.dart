part of robotlegs;

abstract class IViewManager {
	
	List<dynamic> get containers;
	
	void addContainer(dynamic container);

	void removeContainer(dynamic container);

	void addViewHandler(IViewHandler handler);

	void removeViewHandler(IViewHandler handler);
	
	void removeAllHandlers();
}