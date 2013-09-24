package systems;
import components.CameraComponent;
import components.TransformComponent;
import contexts.CameraContext;
import contexts.DisplayContext;
import contexts.ViewContext;
import hxE.ComponentTypeSlot;
import hxE.Demand;
import hxE.Entity;
import hxE.systems.EntityProcessingSystem;
import hxE.systems.VoidEntitySystem;

/**
 * ...
 * @author P Svilans
 */
class CameraSystem extends EntityProcessingSystem
{
	
	private var displayContext:DisplayContext;
	private var viewContext:ViewContext;
	private var cameraContext:CameraContext;
	
	private var transformSlot:ComponentTypeSlot<TransformComponent>;
	private var cameraSlot:ComponentTypeSlot<CameraComponent>;
	
	private var focusEntity:Entity;
	
	public function new() 
	{
		super( new Demand().has( TransformComponent ).has( CameraComponent ) );
		
		transformSlot = new ComponentTypeSlot<TransformComponent>( TransformComponent );
		registerSlot( transformSlot );
		
		cameraSlot = new ComponentTypeSlot<CameraComponent>( CameraComponent );
		registerSlot( cameraSlot );
		
		focusEntity = null;
	}
	
	public function setNullFocus():Void
	{
		focusEntity = null;
	}
	
	override public function initialize():Void 
	{
		displayContext = world.getContext( "DisplayContext", DisplayContext );
		viewContext = world.getContext( "ViewContext", ViewContext );
		cameraContext = world.getContext( "CameraContext", CameraContext );
	}
	
	override public function onEntityAdded(e:Entity):Void 
	{
		cameraContext.cameraEntities.push( e );
	}
	
	override public function onEntityRemoved(e:Entity):Void 
	{
		cameraContext.cameraEntities.remove( e );
	}
	
	override private function processEntity( e:Entity ):Void 
	{
		var camera = cameraSlot.get( e );
		
		if ( camera.isRequestingFocus )
		{
			focusEntity = e;
			camera.isRequestingFocus = false;
		}
	}
	
	override public function onEndProcessing():Void 
	{
		if ( focusEntity != null )
		{
			var transform = transformSlot.get( focusEntity );
			
			var container = displayContext.getContainer();
			
			var dx = -transform.x + viewContext.view.width * 0.5 - container.x;
			var dy = -transform.y + viewContext.view.height * 0.5 - container.y;
			
			var easing = 0.2;
			var d = Math.sqrt( dx * dx + dy * dy );
			
			if ( d > 100.0 ) easing = easing * ( 100.0 / d );
			
			container.x += dx * easing;
			container.y += dy * easing;
		}
	}
	
}