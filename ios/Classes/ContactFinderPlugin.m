#import "ContactFinderPlugin.h"
#import <contact_finder/contact_finder-Swift.h>

@implementation ContactFinderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftContactFinderPlugin registerWithRegistrar:registrar];
}
@end
