#import "MyScreenSaverView.h"
#import <WebKit/WebKit.h>

@implementation MyScreenSaverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        if (isPreview) frame.origin= NSZeroPoint;
        view= [[WKWebView alloc] initWithFrame:frame];
        [self addSubview:view];
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    NSBundle *bundle= [NSBundle bundleWithIdentifier:@"my.MyScreenSaver"];
    NSURL *resourceURL = [NSURL fileURLWithPath:[bundle resourcePath]];
    NSURL *indexURL = [NSURL fileURLWithPath:[bundle pathForResource:@"index" ofType:@"html"]];
    [view loadFileURL:indexURL allowingReadAccessToURL:resourceURL];
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
