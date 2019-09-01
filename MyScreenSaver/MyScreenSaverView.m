#import "MyScreenSaverView.h"

@implementation MyScreenSaverView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        if (isPreview) frame.origin= NSZeroPoint;
        view= [[WKWebView alloc] initWithFrame:frame];
        [view setNavigationDelegate:self];
        [self addSubview:view];
        items = @[@"index", @"",];
//        items = @[@"http://graphicbeats.net/", @"graphicbeats",];
//        items = @[@"https://paveldogreat.github.io/WebGL-Fluid-Simulation/", @"WebGL-Fluid-Simulation",];
//        items = @[@"https://whispering-inlet-27072.herokuapp.com", @"",];
        
        [self setAnimationTimeInterval:1/30.0];
    }
    return self;
}

- (void)startAnimation
{
    NSString *resource= items[0];
    if (resource.length == 0) return;
    if ([resource hasPrefix:@"http"]) {
        [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:resource]]];
    }
    else {
        NSBundle *bundle= [NSBundle bundleWithIdentifier:@"my.MyScreenSaver"];
        NSURL *resourceURL = [NSURL fileURLWithPath:[bundle resourcePath]];
        NSURL *indexURL = [NSURL fileURLWithPath:[bundle pathForResource:resource ofType:@"html"]];
        [view loadFileURL:indexURL allowingReadAccessToURL:resourceURL];
    }
    
    [super startAnimation];
}

- (void)stopAnimation
{
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];

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

@implementation MyScreenSaverView (WKNavigationDelegate)

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if ([[[webView URL] scheme] hasPrefix:@"about"]) return;
    NSString *filename = items[1];
    if (filename.length == 0) return;
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"my.MyScreenSaver"];
    NSString *jsfile = [bundle pathForResource:filename ofType:@"js"];
    NSError *err;
    NSString *jscode = [NSString stringWithContentsOfFile:jsfile
                                                 encoding:NSUTF8StringEncoding
                                                    error:&err];
    [view evaluateJavaScript:jscode completionHandler:nil];
}

@end
