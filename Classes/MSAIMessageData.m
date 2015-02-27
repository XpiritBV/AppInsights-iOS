#import "MSAIMessageData.h"
/// Data contract class for type MessageData.
@implementation MSAIMessageData

/// Initializes a new instance of the class.
- (instancetype)init {
  if(self = [super init]) {
    self.envelopeTypeName = @"Microsoft.ApplicationInsights.Message";
    self.dataTypeName = @"MessageData";
    self.version = @2;
    self.properties = [NSDictionary new];
  }
  return self;
}

///
/// Adds all members of this class to a dictionary
/// @param dictionary to which the members of this class will be added.
///
- (MSAIOrderedDictionary *)serializeToDictionary {
  MSAIOrderedDictionary *dict = [super serializeToDictionary];
  if(self.message != nil) {
    [dict setObject:self.message forKey:@"message"];
  }
  [dict setObject:[NSNumber numberWithInt:(int)self.severityLevel] forKey:@"severityLevel"];
  if(self.properties != nil) {
    [dict setObject:self.properties forKey:@"properties"];
  }
  return dict;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if(self) {
    self.envelopeTypeName =[coder decodeObjectForKey:@"envelopeTypeName"];
    self.dataTypeName = [coder decodeObjectForKey:@"dataTypeName"];
    self.message = [coder decodeObjectForKey:@"self.message"];
    self.severityLevel = (MSAISeverityLevel)[coder decodeIntForKey:@"self.severityLevel"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [super encodeWithCoder:coder];
  [coder encodeObject:self.envelopeTypeName forKey:@"envelopeTypeName"];
  [coder encodeObject:self.dataTypeName forKey:@"dataTypeName"];
  [coder encodeObject:self.message forKey:@"self.message"];
  [coder encodeInt:self.severityLevel forKey:@"self.severityLevel"];
}

@end
