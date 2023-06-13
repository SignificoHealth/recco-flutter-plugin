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

@interface Message ()
+ (Message *)fromList:(NSArray *)list;
+ (nullable Message *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@implementation Message
+ (instancetype)makeWithTitle:(nullable NSString *)title
    text:(nullable NSString *)text {
  Message* pigeonResult = [[Message alloc] init];
  pigeonResult.title = title;
  pigeonResult.text = text;
  return pigeonResult;
}
+ (Message *)fromList:(NSArray *)list {
  Message *pigeonResult = [[Message alloc] init];
  pigeonResult.title = GetNullableObjectAtIndex(list, 0);
  pigeonResult.text = GetNullableObjectAtIndex(list, 1);
  return pigeonResult;
}
+ (nullable Message *)nullableFromList:(NSArray *)list {
  return (list) ? [Message fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.title ?: [NSNull null]),
    (self.text ?: [NSNull null]),
  ];
}
@end

@interface ShadowflightApiCodecReader : FlutterStandardReader
@end
@implementation ShadowflightApiCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128: 
      return [Message fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface ShadowflightApiCodecWriter : FlutterStandardWriter
@end
@implementation ShadowflightApiCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[Message class]]) {
    [self writeByte:128];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface ShadowflightApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation ShadowflightApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[ShadowflightApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[ShadowflightApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *ShadowflightApiGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    ShadowflightApiCodecReaderWriter *readerWriter = [[ShadowflightApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void ShadowflightApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<ShadowflightApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.ShadowflightApi.replyBackTest"
        binaryMessenger:binaryMessenger
        codec:ShadowflightApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(replyBackTestText:error:)], @"ShadowflightApi api (%@) doesn't respond to @selector(replyBackTestText:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_text = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        Message *output = [api replyBackTestText:arg_text error:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.ShadowflightApi.openShadowflightSDK"
        binaryMessenger:binaryMessenger
        codec:ShadowflightApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(openShadowflightSDKUserId:error:)], @"ShadowflightApi api (%@) doesn't respond to @selector(openShadowflightSDKUserId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_userId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api openShadowflightSDKUserId:arg_userId error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
