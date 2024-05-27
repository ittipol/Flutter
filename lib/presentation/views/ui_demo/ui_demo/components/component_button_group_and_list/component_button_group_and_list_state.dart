enum ComponentButtonGroupAndListButton {
  verticalList(0),
  horizontalList(1);

  const ComponentButtonGroupAndListButton(this.value);
  final num value;

  static ComponentButtonGroupAndListButton getByValue(num i) {
    return ComponentButtonGroupAndListButton.values.firstWhere((x) => x.value == i);
  }
}

class ComponentButtonGroupAndListState{
  final ComponentButtonGroupAndListButton selectedButton;
  
  ComponentButtonGroupAndListState({
    this.selectedButton = ComponentButtonGroupAndListButton.verticalList
  });

  copyWith({ComponentButtonGroupAndListButton? selectedButton}) => ComponentButtonGroupAndListState(
    selectedButton: selectedButton ?? this.selectedButton,
  );
}