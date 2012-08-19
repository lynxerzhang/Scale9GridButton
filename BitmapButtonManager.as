package {
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.errors.IllegalOperationError;
import flash.geom.Rectangle;
import flash.utils.Dictionary;
import org.bytearray.display.ScaleBitmap;

/**
 * BitmapButtonManager generate a bitmapScale9 button
 *  
 *  used byteArray.org's ScaleBitmap class
 *  
 *  @example
 *  import flash.geom.Rectangle;
 *	import flash.display.SimpleButton;
 *   
 * 	_mc.gotoAndStop(1); // the _mc is a movieclip, it has four state(up, over, down hittest)
 *	var upData:BitmapData = new BitmapData(_mc.width, _mc.height, true, 0);
 * 	upData.draw(_mc);
 *
 *	_mc.gotoAndStop(2); //go to second state (overState)
 *	var overData:BitmapData = new BitmapData(_mc.width, _mc.height, true, 0);
 *	overData.draw(_mc);
 *
 *	var s:SimpleButton = BitmapButtonManager.generateButton([upData], 300, 100, new Rectangle(4, 4, 94, 28));
 *	addChild(s); //create the button and add to stage
 *  
 */
public class BitmapButtonManager {
	
	/**
	 * generate a scale9 style's sprite
	 * 
	 * @param	display the displayobject or the bitmapData
 	 * @param	preferredW  preferredWidth
	 * @param   preferredH  preferredHeight
	 * @param   scale9  the scale9 rectangle
	 * @param   suppressMouseEnable   set mouseEnabled and mouseChildren property
	 * @return
	 */
	public static function getScaleBitmap(display:*, preferredW:Number, preferredH:Number, scale9:Rectangle, suppressMouseEnable:Boolean = true):Sprite {
		var bitmapD:BitmapData;
		if (display is BitmapData) {
			bitmapD = display;
		}
		else {
			//reg point must in top-left
			if (display is DisplayObject) {
				bitmapD = new BitmapData(display.width, display.height, true, 0);
				bitmapD.draw(display);
			}
		}
		if (bitmapD) {
			var s:Sprite = new Sprite();
			s.mouseEnabled = s.mouseChildren = !suppressMouseEnable;
			ScaleBitmap.draw(bitmapD, s.graphics, preferredW, preferredH, scale9, null, true);
			return s;
		}
		return null;
	}
	
	/**
	 * simpleButton's four state property
	 */
	private static const simpleButtonPropery:Array = ["upState", "overState", "downState", "hitTestState"];
	private static const prefix:String = "bitmapscale9button";
	private static var count:int = 0;
	
	/**
	 * generate a bitmapscale style button, like movieclip's property scale9grid
	 * 
	 * @param	resource    save the button's resource(up, over, down, hittest)
	 * @param	preferredW  preferredWidth 
	 * @param	preferredH  preferredHeight
	 * @param	scale9      the scale9grid
	 * @return
	 */
	public static function generateButton(resource:Array, preferredW:Number, preferredH:Number, scale9:Rectangle):SimpleButton {
		if (!resource || resource.length < 2) {
			throw new IllegalOperationError("BitmapButtonManager's method generateButton catch a error : " + "the argument resource is null or the length is less than two");
			return null;
		}
		
		var len:int = resource.length;
		var ary:Array = [];
		
		for (var i:int = 0; i < len; i ++) {
			ary[ary.length] = getScaleBitmap(resource[i], preferredW, preferredH, scale9);
		}
		
		len = simpleButtonPropery.length;
		var s:SimpleButton = new SimpleButton();
		s.name = prefix + String(++count);
		
		for (i = 0; i < len; i ++) {
			var p:String = simpleButtonPropery[i];
			s[p] = i > ary.length - 1 ? ary[ary.length - 1] : ary[i];
		}
		
		return s;
	}
	
	/*
	public static function dispose(s:SimpleButton):void {
		if (!s && (s.name.slice(0, prefix.length) != prefix)) {
			return;
		}
		var len:int = simpleButtonPropery.length;
		for (var i:int = 0; i < len; i ++) {
			var t:Sprite = 	s[simpleButtonPropery[i]] as Sprite;
			if(t){
				t.graphics.clear();
			}
			s[simpleButtonPropery[i]] = null;
		}
	}
	//*/
}	
}