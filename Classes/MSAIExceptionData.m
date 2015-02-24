#import "MSAIExceptionData.h"
/// Data contract class for type ExceptionData.
@implementation MSAIExceptionData
@synthesize envelopeTypeName = _envelopeTypeName;
@synthesize dataTypeName = _dataTypeName;

/// Initializes a new instance of the class.
- (instancetype)init {
  if(self = [super init]) {
    _envelopeTypeName = @"Microsoft.ApplicationInsights.Exception";
    _dataTypeName = @"ExceptionData";
    self.version = @2;
    self.exceptions = [NSMutableArray new];
    self.properties = [NSDictionary new];
    self.measurements = [NSDictionary new];
  }
  return self;
}

///
/// Adds all members of this class to a dictionary
/// @param dictionary to which the members of this class will be added.
///
- (MSAIOrderedDictionary *)serializeToDictionary {
  MSAIOrderedDictionary *dict = [super serializeToDictionary];
  if(self.handledAt != nil) {
    [dict setObject:self.handledAt forKey:@"handledAt"];
  }
  if(self.exceptions != nil) {
    NSMutableArray *exceptionsArray = [NSMutableArray array];
    for (MSAIExceptionDetails *exceptionsElement in self.exceptions) {
      [exceptionsArray addObject:[exceptionsElement serializeToDictionary]];
    }
    [dict setObject:exceptionsArray forKey:@"exceptions"];
  }
  [dict setObject:[NSNumber numberWithInt:(int)self.severityLevel] forKey:@"severityLevel"];
  if(self.problemId != nil) {
    [dict setObject:self.problemId forKey:@"problemId"];
  }
  if(self.crashThreadId != nil) {
    [dict setObject:self.crashThreadId forKey:@"crashThreadId"];
  }
  if(self.properties != nil) {
    [dict setObject:self.properties forKey:@"properties"];
  }
  if(self.measurements != nil) {
    [dict setObject:self.measurements forKey:@"measurements"];
  }
  return dict;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if(self) {
    _envelopeTypeName =[coder decodeObjectForKey:@"_envelopeTypeName"];
    _dataTypeName = [coder decodeObjectForKey:@"_dataTypeName"];
    self.version = [coder decodeObjectForKey:@"self.version"];
    self.handledAt = [coder decodeObjectForKey:@"self.handledAt"];
    self.exceptions = [coder decodeObjectForKey:@"self.exceptions"];
    self.severityLevel = (MSAISeverityLevel)[coder decodeIntForKey:@"self.severityLevel"];
    self.problemId = [coder decodeObjectForKey:@"self.problemId"];
    self.crashThreadId = [coder decodeObjectForKey:@"self.crashThreadId"];
    self.properties = [coder decodeObjectForKey:@"self.properties"];
    self.measurements = [coder decodeObjectForKey:@"self.measurements"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [super encodeWithCoder:coder];
  [coder encodeObject:_envelopeTypeName forKey:@"_envelopeTypeName"];
  [coder encodeObject:_dataTypeName forKey:@"_dataTypeName"];
  [coder encodeObject:self.version forKey:@"self.version"];
  [coder encodeObject:self.handledAt forKey:@"self.handledAt"];
  [coder encodeObject:self.exceptions forKey:@"self.exceptions"];
  [coder encodeInt:self.severityLevel forKey:@"self.severityLevel"];
  [coder encodeObject:self.problemId forKey:@"self.problemId"];
  [coder encodeObject:self.crashThreadId forKey:@"self.crashThreadId"];
  [coder encodeObject:self.properties forKey:@"self.properties"];
  [coder encodeObject:self.measurements forKey:@"self.measurements"];
}

@end
