#import "CedarAdditions.h"
#import <Cedar/CDRSpec.h>

void context(NSString *text, CDRSpecBlock block) {
  describe(text, block);
}

void xcontext(NSString *text, CDRSpecBlock block) {
  it(text, PENDING);
}

void xdescribe(NSString *text, CDRSpecBlock block) {
  it(text, PENDING);
}

void xit(NSString *text, CDRSpecBlock block) {
  it(text, PENDING);
}
