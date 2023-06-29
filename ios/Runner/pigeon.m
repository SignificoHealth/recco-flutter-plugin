// Autogenerated from Pigeon (v10.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "pigeon.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}
static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

NSObject<FlutterMessageCodec> *ReccoApiGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  sSharedObject = [FlutterStandardMessageCodec sharedInstance];
  return sSharedObject;
}

void ReccoApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<ReccoApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.ReccoApi.login"
        binaryMessenger:binaryMessenger
        codec:ReccoApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(loginUserId:error:)], @"ReccoApi api (%@) doesn't respond to @selector(loginUserId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_userId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api loginUserId:arg_userId error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.ReccoApi.logout"
        binaryMessenger:binaryMessenger
        codec:ReccoApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(logoutWithError:)], @"ReccoApi api (%@) doesn't respond to @selector(logoutWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api logoutWithError:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.ReccoApi.navigateToDashboard"
        binaryMessenger:binaryMessenger
        codec:ReccoApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(navigateToDashboardWithError:)], @"ReccoApi api (%@) doesn't respond to @selector(navigateToDashboardWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api navigateToDashboardWithError:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
