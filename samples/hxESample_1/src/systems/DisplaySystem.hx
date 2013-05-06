package systems;
import components.DisplayComponent;
import components.TransformComponent;
import flash.display.Sprite;
import hxE.ComponentTypeSlot;
import hxE.Demand;
import hxE.Entity;
import hxE.systems.EntityProcessingSystem;

/**
 * ...
 * @author P Svilans
 */
class DisplaySystem extends EntityProcessingSystem
{
	
	private var container:Sprite;
	
	private var transformSlot:ComponentTypeSlot<TransformComponent>;
	private var displaySlot:ComponentTypeSlot<DisplayComponent>;

	public function new() 
	{
		super( new Demand().has( TransformComponent).has( DisplayComponent));
		
		// Currently this is a really verbose way doing things, not sure if there are any work arounds.
		transformSlot = new ComponentTypeSlot<TransformComponent>(TransformComponent);
		displaySlot = new ComponentTypeSlot<DisplayComponent>(DisplayComponent);
		
		// MUST REGISTER slots you want to use!
		registerSlot( transformSlot);
		registerSlot( displaySlot);
		
		container = new Sprite();
	}
	
	public function getContainer():Sprite
	{
		return container;
	}
	
	override public function onEntityAdded(e:Entity):Void 
	{
		var transform = transformSlot.get( e);
		var display = displaySlot.get( e);
		
		// Initialize the display's graphic to the transforms position.
		display.graphic.x = transform.x;
		display.graphic.y = transform.y;
		
		display.graphic.rotation = transform.rotation;
		
		// Add the display's graphic to our container!
		container.addChild( display.graphic);
	}
	
	override private function processEntity(e:Entity):Void 
	{
		var transform = transformSlot.get( e);
		var display = displaySlot.get( e);
		
		// Copy transform coordinates and rotation to the graphic
		display.graphic.x = transform.x;
		display.graphic.y = transform.y;
		
		display.graphic.rotation = transform.rotation;
	}
	
}