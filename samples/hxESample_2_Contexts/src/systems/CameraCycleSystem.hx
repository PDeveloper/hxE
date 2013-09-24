package systems;
import components.CameraComponent;
import contexts.CameraContext;
import hxE.ComponentTypeSlot;
import hxE.systems.VoidIntervalSystem;

/**
 * ...
 * @author P Svilans
 */
class CameraCycleSystem extends VoidIntervalSystem
{
	
	private var cameraContext:CameraContext;
	
	private var cameraSlot:ComponentTypeSlot<CameraComponent>;
	
	public function new() 
	{
		super( 3.0 );
		
		cameraSlot = new ComponentTypeSlot<CameraComponent>( CameraComponent );
		registerSlot( cameraSlot );
	}
	
	override public function initialize():Void 
	{
		cameraContext = world.getContext( "CameraContext", CameraContext );
	}
	
	override private function processSystem():Void 
	{
		if ( cameraContext.cameraEntities.length > 0 )
		{
			var r = Std.int( Math.random() * cameraContext.cameraEntities.length );
			
			var camera = cameraSlot.get( cameraContext.cameraEntities[ r ] );
			camera.requestFocus();
		}
	}
	
}