//
//  CoreTextView.m
//  SimpleCoreText
//
//  Created by Michael Luton on 5/10/12.
//  Copyright (c) 2012 Michael Luton. All rights reserved.
//

#import "CoreTextView.h"
#import <CoreText/CoreText.h>

@implementation CoreTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        // Create the attributed string we wish to display. This is where we
        // specify any special formatting within the string. In this case
        // we're simply specifying the entire string be set in Futura at
        // 24 points.
        string = [[NSMutableAttributedString alloc] initWithString:@"A mountain of milk."];
        CTFontRef aFont = CTFontCreateWithName((__bridge CFStringRef)@"Futura", 24.0, NULL);
        [string addAttribute:(NSString*)kCTFontAttributeName value:(__bridge id)aFont range:NSMakeRange(0, [string length])];
    }
    
    // Make sure the background is transparent. Otherwise, nothing but a black
    // rectangle will appear.
    self.backgroundColor = [UIColor clearColor];
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // We're about to start the drawing. Save the graphics context because
    // we're going to be doing some stuff to it and will want to return the
    // graphics context to its original state when we're done.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);

    // Flip the coordinate plane. In iOS the origin is at the top left but in
    // the core API the origin in at the bottom left. Therefore we need to
    // flip the coordinate plane so everything turns out right.
    CGContextConcatCTM(ctx, CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f));

    // Creates an immutable framesetter object from an attributed string. The
    // resultant framesetter object can be used to create and fill text frames
    // with the CTFramesetterCreateFrame call. At this point the framesetter
    // object contains the fully typeset string. It just needs to know the size
    // and shape on the container it will be placed into.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)string);

    // Here is where we define the size and shape of the container for the
    // string we want to display. This takes the form of a path object. In this
    // case the path is simply the rectable of this view.
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);

    // Create a frame full of glyphs in the shape of the path provided by the
    // path parameter.
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0,0), path, NULL);

    // Decrement the retain count of the path and framesetter.
    CGPathRelease(path);
    CFRelease(framesetter);

    // Actually draw the frame into the context.
    CTFrameDraw(textFrame, ctx);

    // We're done. Restore the graphics context to its original state.
    CGContextRestoreGState(ctx);
}

@end
