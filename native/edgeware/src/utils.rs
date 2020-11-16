/// Split `u128` into (lo: u64, hi: u64)
#[inline(always)]
#[allow(unused)]
pub const fn u128_split(v: u128) -> (u64, u64) {
    let lo = v as u64;
    let hi = (v >> 64u64) as u64;
    (lo, hi)
}
