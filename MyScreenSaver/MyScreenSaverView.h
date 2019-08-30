#import <ScreenSaver/ScreenSaver.h>
#import <WebKit/WebKit.h>

@interface MyScreenSaverView : ScreenSaverView <WKNavigationDelegate>
{
	WKWebView *view;
    NSArray *items;
}
@end
