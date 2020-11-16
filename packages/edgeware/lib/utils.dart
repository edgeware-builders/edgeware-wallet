BigInt constract(int lo, int hi) {
  final val = BigInt.from(lo) | (BigInt.from(hi) << 64);
  return val;
}
