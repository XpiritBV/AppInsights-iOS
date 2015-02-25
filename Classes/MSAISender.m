#import "MSAISender.h"
#import "MSAIAppClient.h"
#import "MSAISenderPrivate.h"
#import "MSAIPersistence.h"
#import "MSAIEnvelope.h"
#import "AppInsightsPrivate.h"

@interface MSAISender ()

@property (nonatomic, strong) NSArray *currentBundle;
@property (getter=isSending) BOOL sending;

@end

@implementation MSAISender

@synthesize sending = _sending;

#pragma mark - Initialize & configure shared instance

+ (instancetype)sharedSender {
  static MSAISender *sharedInstance = nil;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    sharedInstance = [MSAISender new];
  });
  return sharedInstance;
}

#pragma mark - Network status

- (void)configureWithAppClient:(MSAIAppClient *)appClient endpointPath:(NSString *)endpointPath {
  self.endpointPath = endpointPath;
  self.appClient = appClient;
  [self registerObservers];
}

#pragma mark - Handle persistence events

- (void)registerObservers{
  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  __weak typeof(self) weakSelf = self;
  [center addObserverForName:kMSAIPersistenceSuccessNotification
                      object:nil
                       queue:nil
                  usingBlock:^(NSNotification *note) {
                    typeof(self) strongSelf = weakSelf;
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                      
                      // If something was persisted, we have to send it to the server.
                      [strongSelf sendSavedData];
                    });
                  }];
}

#pragma mark - Sending

- (void)sendSavedData {
  
  @synchronized(self){
    if(_sending)
      return;
    else
      _sending = YES;
  }
  
  NSArray *bundle = [MSAIPersistence nextBundle];
  if(bundle && bundle.count > 0 && !self.currentBundle) {
    self.currentBundle = bundle;
    NSError *error = nil;
    NSData *json = [[self jsonStringFromArray:bundle] dataUsingEncoding:NSUTF8StringEncoding];
    if(!error) {
      NSString *urlString = [[(MSAIEnvelope *)bundle[0] name] isEqualToString:@"Microsoft.ApplicationInsights.Crash"] ? MSAI_CRASH_DATA_URL : MSAI_EVENT_DATA_URL;
      NSURLRequest *request = [self requestForData:json urlString:urlString];
      [self sendRequest:request];
    }
    else {
      MSAILog(@"Error creating JSON from bundle array, saving bundle back to disk");
      [MSAIPersistence persistBundle:bundle ofType:MSAIPersistenceTypeRegular withCompletionBlock:nil];
      self.sending = NO;
    }
  }else{
    self.sending = NO;
  }
}

- (void)sendRequest:(NSURLRequest *)request {
  __weak typeof(self) weakSelf = self;
  
  MSAIHTTPOperation *operation = [self.appClient
                                  operationWithURLRequest:request
                                  completion:^(MSAIHTTPOperation *operation, NSData *responseData, NSError *error) {
                                    
                                    typeof(self) strongSelf = weakSelf;
                                    NSInteger statusCode = [operation.response statusCode];
                                    self.currentBundle = nil;
                                    self.sending = NO;
                                    if(statusCode >= 200 && statusCode < 400) {
                                      
                                      MSAILog(@"Sent data with status code: %ld", (long) statusCode);
                                      MSAILog(@"Response data:\n%@", [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil]);
                                      
                                      [strongSelf sendSavedData];
                                      
                                    } else {
                                      MSAILog(@"Sending failed");
                                    
                                      //[MSAIPersistence persistBundle:self.currentBundle];
                                      //TODO maybe trigger sending again or notify someone?
                                    }
                                  }];
  
  [self.appClient enqeueHTTPOperation:operation];
}

- (void)sendRequest:(NSURLRequest *)request withCompletionBlock:(MSAINetworkCompletionBlock)completion{
  MSAIHTTPOperation *operation = [_appClient
                                  operationWithURLRequest:request
                                  completion:completion];
  [_appClient enqeueHTTPOperation:operation];
}

#pragma mark - Helper

- (NSString *)jsonStringFromArray:(NSArray *)envelopeArray{
  NSMutableString *string = [NSMutableString new];
  for(MSAIEnvelope *envelope in envelopeArray){
    [string appendFormat:@"%@\n", [envelope serializeToString]];
  }
  return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSURLRequest *)requestForData:(NSData *)data urlString:(NSString *)urlString {
  NSMutableURLRequest *request = [self.appClient requestWithMethod:@"POST"
                                                              path:urlString
                                                        parameters:nil];
  
  [request setHTTPBody:data];
  [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
  NSString *contentType = @"application/json";
  [request setValue:contentType forHTTPHeaderField:@"Content-type"];
  return request;
}

#pragma mark - Getter/Setter

- (BOOL)isSending {
  @synchronized(self){
    return _sending;
  }
}

- (void)setSending:(BOOL)sending {
  @synchronized(self){
    _sending = sending;
  }
}

@end
