#import "FlutterLocalizedCountryNamePlugin.h"
#if __has_include(<flutter_localized_country_name/flutter_localized_country_name-Swift.h>)
#import <flutter_localized_country_name/flutter_localized_country_name-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_localized_country_name-Swift.h"
#endif

@implementation FlutterLocalizedCountryNamePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterLocalizedCountryNamePlugin registerWithRegistrar:registrar];
}
@end
