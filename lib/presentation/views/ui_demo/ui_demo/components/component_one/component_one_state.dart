enum ComponentOneButton {
  verticalList(0),
  horizontalList(1);

  const ComponentOneButton(this.value);
  final num value;

  static ComponentOneButton getByValue(num i) {
    return ComponentOneButton.values.firstWhere((x) => x.value == i);
  }
}

class ComponentOneState{
  final ComponentOneButton selectedButton;
  
  ComponentOneState({
    this.selectedButton = ComponentOneButton.verticalList
  });

  copyWith({ComponentOneButton? selectedButton}) => ComponentOneState(
    selectedButton: selectedButton ?? this.selectedButton,
  );
}