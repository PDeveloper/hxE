package ;

import components.DisplayComponent;
import components.TargetComponent;
import components.TransformComponent;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.Lib;
import haxe.Timer;
import hxE.EntityWorld;
import systems.DisplaySystem;
import systems.RetargetSystem;
import systems.TargetSystem;

/**
 * ...
 * @author P Svilans
 */

class Main extends Sprite
{
	
	var world:EntityWorld;
	
	var displaySystem:DisplaySystem;
	var targetSystem:TargetSystem;
	var retargetSystem:RetargetSystem;
	
	var timeStep:Float;
	
	public function new()
	{
		super();
		world = new EntityWorld();
		
		// Create the systems we'll be using
		displaySystem = new DisplaySystem();
		targetSystem = new TargetSystem();
		retargetSystem = new RetargetSystem( new Rectangle( 0.0, 0.0, 800.0, 600.0));
		
		// Add the systems to the EntityWorld
		world.addSystem( displaySystem);
		world.addSystem( targetSystem);
		world.addSystem( retargetSystem);
		
		// Add the display systems container so we can see something
		addChild( displaySystem.getContainer());
		
		if ( stage == null) addEventListener( Event.ADDED_TO_STAGE, init);
		else init();
	}
	
	private function init( e:Event = null):Void
	{
		if ( e != null) removeEventListener( Event.ADDED_TO_STAGE, init);
		
		// Create 100 entities.
		for ( i in 0...100)
		{
			var e = world.create();
			
			var graphic:Sprite = new Sprite();
			
			var g = graphic.graphics;
			g.beginFill( Std.int( Math.random() * 2147483647), 1.0);
			
			var blockWidth:Float = Math.random() * 20.0 + 10.0;
			var blockHeight:Float = Math.random() * 20.0 + 10.0;
			
			g.drawRect( blockWidth * -0.5, blockHeight * -0.5, blockWidth, blockHeight);
			
			var display = new DisplayComponent( graphic);
			var transform = new TransformComponent( Math.random() * stage.stageWidth,
													Math.random() * stage.stageHeight,
													Math.random() * 360.0
			);
			var target = new TargetComponent( Math.random() * stage.stageWidth,
												Math.random() * stage.stageHeight
			);
			
			// Add the components
			e.addComponent( display);
			e.addComponent( transform);
			e.addComponent( target);
			
			// MUST update the entity after adding or removing components!!!
			e.update();
		}
		
		timeStep = Timer.stamp();
		addEventListener( Event.ENTER_FRAME, enterFrame);
	}
	
	private function enterFrame( e:Event):Void
	{
		timeStep = Timer.stamp() - timeStep;
		
		// Update the systems. You can give whichever timestep you want (seconds or milliseconds), since it's up to you to use the timestep in your own systems.
		world.updateSystems( timeStep);
		
		timeStep = Timer.stamp();
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