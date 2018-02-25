using Toybox.WatchUi as Ui;

class MyRectangle extends Ui.Drawable
{
    var x, y, w, h, lineWidth, borderWidth, bgColor, borderColor;

    // pass location as locX, locY params
    function initialize(options) {
        Drawable.initialize(options);
        x = options[:left];
        y = options[:top];
        w = options[:width];
        h = options[:height];
        lineWidth = options[:lineWidth];
    }

    function setColor(b1, b2) {
        bgColor = b1;
        borderColor = b2;
    }

    function draw(dc) {
      //draw your battery here, you can use the drawables x and y position as an offset
      //and optionaly scale the drawing based on the drawables width and/or height
      dc.setColor(bgColor, -1);
      dc.fillRectangle(x, y, w, h);
	  if (lineWidth > 0) {
        dc.setColor(borderColor, bgColor);
        dc.setPenWidth(lineWidth);
        dc.drawRectangle(x, y, w, h);
	  }
    }
}
