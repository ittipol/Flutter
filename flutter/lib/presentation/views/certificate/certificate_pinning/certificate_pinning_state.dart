class CertificatePinningState{
  final bool isCert1Allowed;
  final bool isCert2Allowed;
  
  CertificatePinningState({
    this.isCert1Allowed = true,
    this.isCert2Allowed = false
  });

  copyWith({bool? isCert1Allowed, bool? isCert2Allowed}) => CertificatePinningState(
    isCert1Allowed: isCert1Allowed ?? this.isCert1Allowed,
    isCert2Allowed: isCert2Allowed ?? this.isCert2Allowed
  );
}