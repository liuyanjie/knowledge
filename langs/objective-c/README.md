# Objective-C

## Class

```obj-c
@interface Student : NSObject

  @property NSString *name;
  @property int age;
  @property float score;

  -(void) display;

@end

@implementation Student
  - (void) display {
      NSLog(@"%@的年龄是 %d，成绩是 %f", self.name, self.age, self.score);
  }
@end
```
