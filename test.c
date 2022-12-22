
#include preproc.c

float Q_rsqrt(float number) {
  long i;
  float x2, y;
  const float threehalfs = 1.5F;

  x2 = number * 0.5F;
  y = number;
  i = *(long *)&y;
  i = 0x5f3759df - (i >> 1);
  y = *(float *)&i;
  y = y * (threehalfs - (x2 * y * y));
  //    y = y * ( threehalfs - ( x2 * y * y) );
  return y;
}

// ; eval (buf): ...uryasingh/*scratch*
// "{:base00 \"#161616\"
//  :base01 \"#262626\"
//  :base02 \"#393939\"
//  :base03 \"#525252\"
//  :base04 \"#d0d0d0\"
//  :base05 \"#f2f2f2\"
//  :base06 \"#ffffff\"
//  :base07 \"#08bdba\"
//  :base08 \"#3ddbd9\"
//  :base09 \"#78a9ff\"
//  :base10 \"#ee5396\"
//  :base11 \"#33b1ff\"
//  :base12 \"#ff7eb6\"
//  :base13 \"#42be65\"
//  :base14 \"#be95ff\"
//  :base15 \"#82cfff\"
//  :blend \"#131313\"
//  :none \"NONE\"}"
