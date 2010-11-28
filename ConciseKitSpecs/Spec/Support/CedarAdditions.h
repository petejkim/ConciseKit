#import <Cedar/CDRExampleBase.h>

#ifdef __cplusplus
extern "C" {
#endif
  void context(NSString *, CDRSpecBlock);
  void xcontext(NSString *, CDRSpecBlock);
  void xdescribe(NSString *, CDRSpecBlock);
  void xit(NSString *, CDRSpecBlock);
#ifdef __cplusplus
}
#endif