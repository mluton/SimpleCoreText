This is a simple demonstration of how to use CoreText to draw text in an iOS application.

The application consists of a `UIViewController` and a `UIView`. The view controller creates an instance of the view and adds it as a subview. The view uses CoreText to draw a string of text in it's `drawRect` method. The `drawRect` method is where all the interesting code is at.

The `drawRect` method is very heavily commented in an attempt to explain to myself how everything works. Hopefully, other people can benefit from this as well. Here's the basic rundown. This assumes a `NSMutableAttributedString` instance variable named `string` has been initialized in the view's `initWithFrame` method. I'm going to omit the typical `drawRect` boilerplate code of saving the device context, flipping the coordinate plane, and any memory management in order to focus on the CoreText code. See the GitHub project for the complete implementation.

1. Create a `CTFrameSetterRef` object. The framesetter object contains the fully typeset string. But you can't use this to display it on screen. For that to happen you need to define the size and shape on the container it will be placed into. (The code below is ARC compliant hence the `__bridge` cast. Omit the `__bridge` cast for non-ARC projects.)

        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)string);

2.  In this simple example the size and shape of the container will be the boundaries of the view itself. This should be defined as a `CGPath` because it is possible for text to exist within shapes other than basic rectangles.

        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, self.bounds);

3. Now that we have a framesetter object and the path in which it will be displayed we can create the `CTFrameRef` object. This is what will be used to actually display the text on screen. The `CTFrameDraw` is what actually draws the text.

        CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0,0), path, NULL);
        CTFrameDraw(textFrame, ctx);

Useful documentation includes Apple's [CTFrameSetter Reference](https://developer.apple.com/library/mac/#documentation/Carbon/Reference/CTFramesetterRef/Reference/reference.html) and [CTFrame Reference](https://developer.apple.com/library/mac/#documentation/Carbon/Reference/CTFrameRef/Reference/reference.html)

Comments, Feedback, Suggestions: [Michael Luton](mailto:mluton@gmail.com)

MIT license.
