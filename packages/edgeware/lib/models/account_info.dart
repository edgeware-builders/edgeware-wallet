import 'package:edgeware/ffi.dart' as ffi;
import 'package:ffi/ffi.dart';

class AccountInfo {
  AccountInfo._({this.free, this.reserved, this.miscFrozen, this.feeFrozen});
  // ignore: prefer_constructors_over_static_methods
  static AccountInfo fromFFI(ffi.AccountInfo info) {
    return AccountInfo._(
      free: BigInt.parse(Utf8.fromUtf8(info.free.cast())),
      feeFrozen: BigInt.parse(Utf8.fromUtf8(info.fee_frozen.cast())),
      miscFrozen: BigInt.parse(Utf8.fromUtf8(info.misc_frozen.cast())),
      reserved: BigInt.parse(Utf8.fromUtf8(info.reserved.cast())),
    );
  }

  /// Non-reserved part of the balance. There may still be restrictions on
  /// this, but it is the total pool what may in principle be
  /// transferred, reserved and used for tipping.
  ///
  /// This is the only balance that matters in terms of most operations on
  /// tokens. It alone is used to determine the balance when in the
  /// contract execution environment.
  final BigInt free;

  /// Balance which is reserved and may not be used at all.
  ///
  /// This can still get slashed, but gets slashed last of all.
  ///
  /// This balance is a 'reserve' balance that other subsystems use in order
  /// to set aside tokens that are still 'owned' by the account holder,
  /// but which are suspendable.
  final BigInt reserved;

  /// The amount that `free` may not drop below when withdrawing for
  /// *anything except transaction fee payment*.
  final BigInt miscFrozen;

  /// The amount that `free` may not drop below when withdrawing specifically
  /// for transaction fee payment.
  final BigInt feeFrozen;

  @override
  String toString() {
    return 'AccountInfo { free: $free, reserved: $reserved }';
  }
}
