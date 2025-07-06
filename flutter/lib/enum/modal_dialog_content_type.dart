enum ModalDialogContentType { 
  none(0),
  howToStartServer(1),
  androidSetProxyAddress(2);

  const ModalDialogContentType(this.value);
  final num value;

  static ModalDialogContentType getByValue(num i) {
    return ModalDialogContentType.values.firstWhere((x) => x.value == i, orElse: () => defaultValue);
  }

  static ModalDialogContentType defaultValue = none;
}