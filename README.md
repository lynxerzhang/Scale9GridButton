Scale9GridButton
=================

**use 'org.bytearray.display.ScaleBitmap' to create 9slice displayobject, e.g: 'a 9slice simpleButton'**

#Example

    //create a 400 * 300 9slice's Sprite
    var s:Sprite = BitmapButtonManager.getScaleBitmap(_mc, 400, 300, new Rectangle(23, 24, 47, 47));
    
    //create a 9slice's simpleButton
	var upState:BitmapData = new BitmapData(_mc.width, _mc.height, true, 0);
	var downState:BitmapData = upState.clone();

	upState.draw(_mc, null, _mc.transform.colorTransform); //draw the upState
	downState.draw(_mc, null, _mc2.transform.colorTransform); //draw the overState

	var b:SimpleButton = BitmapButtonManager.generateButton([upState, downState], 
								100, 60, new Rectangle(23, 24, 47, 47));
	addChild(b);
	b.addEventListener(MouseEvent.CLICK, function(evt:MouseEvent):void{
		trace("click");
	});
