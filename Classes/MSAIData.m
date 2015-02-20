#import "MSAIData.h"
/// Data contract class for type Data.
@implementation MSAIData

/// Initializes a new instance of the class.
- (instancetype)init {
  if(self = [super init]) {
  }
  return self;
}

///
/// Adds all members of this class to a dictionary
/// @param dictionary to which the members of this class will be added.
///
- (MSAIOrderedDictionary *)serializeToDictionary {
  MSAIOrderedDictionary *dict = [super serializeToDictionary];
  if(self.baseData != nil) {
    if([NSJSONSerialization isValidJSONObject:[self.baseData serializeToDictionary]]) {
      [dict setObject:[self.baseData serializeToDictionary] forKey:@"baseData"];
    }
  }
  return dict;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if(self) {
    self.baseData = [coder decodeObjectForKey:@"self.baseData"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [super encodeWithCoder:coder];
  [coder encodeObject:self.baseData forKey:@"self.baseData"];
}

@end
