part of robotlegs;

abstract class IViewManager {
	
	List<dom.Element> get containers;
	
	void addContainer(dynamic container);

	void removeContainer(dynamic container);

	void addViewHandler(IViewHandler handler);

	void removeViewHandler(IViewHandler handler);
	
	void removeAllHandlers();
}