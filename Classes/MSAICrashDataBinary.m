#import "MSAICrashDataBinary.h"
/// Data contract class for type CrashDataBinary.
@implementation MSAICrashDataBinary

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
  if(self.startAddress != nil) {
    [dict setObject:self.startAddress forKey:@"startAddress"];
  }
  if(self.endAddress != nil) {
    [dict setObject:self.endAddress forKey:@"endAddress"];
  }
  if(self.name != nil) {
    [dict setObject:self.name forKey:@"name"];
  }
  if(self.cpuType != nil) {
    [dict setObject:self.cpuType forKey:@"cpuType"];
  }
  if(self.cpuSubType != nil) {
    [dict setObject:self.cpuSubType forKey:@"cpuSubType"];
  }
  if(self.uuid != nil) {
    [dict setObject:self.uuid forKey:@"uuid"];
  }
  if(self.path != nil) {
    [dict setObject:self.path forKey:@"path"];
  }
  return dict;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)coder {
  self = [super init];
  if(self) {
    self.startAddress = [coder decodeObjectForKey:@"self.startAddress"];
    self.endAddress = [coder decodeObjectForKey:@"self.endAddress"];
    self.name = [coder decodeObjectForKey:@"self.name"];
    self.cpuType = [coder decodeObjectForKey:@"self.cpuType"];
    self.cpuSubType = [coder decodeObjectForKey:@"self.cpuSubType"];
    self.uuid = [coder decodeObjectForKey:@"self.uuid"];
    self.path = [coder decodeObjectForKey:@"self.path"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeObject:self.startAddress forKey:@"self.startAddress"];
  [coder encodeObject:self.endAddress forKey:@"self.endAddress"];
  [coder encodeObject:self.name forKey:@"self.name"];
  [coder encodeObject:self.cpuType forKey:@"self.cpuType"];
  [coder encodeObject:self.cpuSubType forKey:@"self.cpuSubType"];
  [coder encodeObject:self.uuid forKey:@"self.uuid"];
  [coder encodeObject:self.path forKey:@"self.path"];
}

@end
