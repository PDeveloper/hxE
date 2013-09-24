package ;

import components.CameraComponent;
import components.DirectionComponent;
import components.DisplayComponent;
import components.TransformComponent;
import contexts.DisplayContext;
import contexts.ViewContext;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.Lib;
import haxe.Timer;
import hxE.EntityWorld;
import systems.CameraCycleSystem;
import systems.CameraSystem;
import systems.DisplaySystem;
import systems.PropulsionSystem;

/**
 * ...
 * @author P Svilans
 */

class Main extends Sprite
{
	
	var world:EntityWorld;
	
	var displaySystem:DisplaySystem;
	var cameraSystem:CameraSystem;
	var propulsionSystem:PropulsionSystem;
	
	var cameraCycleSystem:CameraCycleSystem;
	
	var timeStep:Float;
	
	public function new()
	{
		super();
		
		if ( stage == null) addEventListener( Event.ADDED_TO_STAGE, init);
		else init();
	}
	
	private function init( e:Event = null):Void
	{
		if ( e != null) removeEventListener( Event.ADDED_TO_STAGE, init);
		
		world = new EntityWorld();
		
		// Set up the world contexts.
		var displayContext:DisplayContext = world.getContext( "DisplayContext", DisplayContext );
		addChild( displayContext.getContainer() );
		
		var viewContext:ViewContext = world.getContext( "ViewContext", ViewContext );
		viewContext.set( 0.0, 0.0, stage.stageWidth, stage.stageHeight );
		
		// Create the systems we'll be using
		displaySystem = new DisplaySystem();
		cameraSystem = new CameraSystem();
		propulsionSystem = new PropulsionSystem();
		
		cameraCycleSystem = new CameraCycleSystem();
		
		// Add the systems to the EntityWorld
		world.addSystem( displaySystem );
		world.addSystem( cameraSystem );
		world.addSystem( propulsionSystem );
		
		world.addSystem( cameraCycleSystem );
		
		// Create 100 entities.
		for ( i in 0...100)
		{
			createFlyer( Math.random() < 0.25 );
		}
		
		timeStep = Timer.stamp();
		addEventListener( Event.ENTER_FRAME, enterFrame);
	}
	
	private function enterFrame( e:Event):Void
	{
		timeStep = Timer.stamp() - timeStep;
		
		// Update the systems. You can give whichever timestep you want (seconds or milliseconds), since it's up to you to use the timestep in your own systems.
		world.updateSystems( timeStep );
		
		timeStep = Timer.stamp();
	}
	
	private function createFlyer( createCamera:Bool = false ):Void
	{
		var e = world.create();
		
		var graphic:Sprite = new Sprite();
		
		var blockWidth:Float = Math.random() * 20.0 + 14.0;
		var blockHeight:Float = blockWidth * ( Math.random() * 0.4 + 0.4 );
		
		var g = graphic.graphics;
		g.beginFill( Std.int( Math.random() * 2147483647), 1.0);
		
		g.moveTo( blockWidth * 0.5, 0.0 );
		g.lineTo( -blockWidth * 0.5, blockHeight * 0.5 );
		g.lineTo( -blockWidth * 0.3, 0.0 );
		g.lineTo( -blockWidth * 0.5, -blockHeight * 0.5 );
		g.lineTo( blockWidth * 0.5, 0.0 );
		
		g.endFill();
		
		var display = new DisplayComponent( graphic );
		var transform = new TransformComponent( Math.random() * stage.stageWidth,
												Math.random() * stage.stageHeight,
												Math.random() * 360.0
		);
		var direction = new DirectionComponent();
		direction.angle = Math.random() * Math.PI * 2.0;
		
		if ( createCamera )
		{
			var camera = new CameraComponent();
			camera.requestFocus();
			
			e.addComponent( camera );
		}
		
		// Add the components
		e.addComponent( display );
		e.addComponent( transform );
		e.addComponent( direction );
		
		// MUST update the entity after adding or removing components!!!
		e.update();
	}
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		
		Lib.current.addChild( new Main());
	}
	
}