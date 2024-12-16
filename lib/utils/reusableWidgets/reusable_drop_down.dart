import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

enum DropdownType {
  basic,
  searchable,
  multiSelect,
}

class ReusableDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final List<T>? selectedItems;
  final void Function(T?)? onChanged;
  final void Function(List<T>)? onMultiChanged;
  final Widget Function(T) itemBuilder;
  final Widget? hint;
  final DropdownType type;
  final bool isExpanded;
  final ButtonStyleData buttonStyleData;
  final IconStyleData iconStyleData;
  final DropdownStyleData dropdownStyleData;
  final MenuItemStyleData menuItemStyleData;
  final TextEditingController? searchController;
  final Widget Function(Widget searchWidget)? searchInnerWidgetFn;
  final String? Function(T?)? validator;
  final String? Function(List<T>?)? multiValidator;
  final TextStyle itemTextStyle;
  final TextStyle selectedItemTextStyle;

  ReusableDropdown({
    super.key,
    required this.items,
    this.value,
    this.selectedItems,
    required this.onChanged,
    this.onMultiChanged,
    required this.itemBuilder,
    this.hint,
    this.type = DropdownType.basic,
    this.isExpanded = false,
    ButtonStyleData? buttonStyleData,
    IconStyleData? iconStyleData,
    DropdownStyleData? dropdownStyleData,
    MenuItemStyleData? menuItemStyleData,
    this.searchController,
    this.searchInnerWidgetFn,
    this.validator,
    this.multiValidator,
    TextStyle? itemTextStyle,
    TextStyle? selectedItemTextStyle,
  })  : buttonStyleData = buttonStyleData ??
            ButtonStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
        iconStyleData = iconStyleData ??
            const IconStyleData(
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              iconSize: 24,
            ),
        dropdownStyleData = dropdownStyleData ??
            DropdownStyleData(
              maxHeight: 200,
              width: 200,
              padding: null,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              elevation: 8,
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: WidgetStateProperty.all(6),
                thumbVisibility: WidgetStateProperty.all(true),
              ),
            ),
        menuItemStyleData = menuItemStyleData ??
            const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
        itemTextStyle = itemTextStyle ?? const TextStyle(color: Colors.black),
        selectedItemTextStyle = selectedItemTextStyle ??
            const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case DropdownType.basic:
        return _buildBasicDropdown(context);
      case DropdownType.searchable:
        return _buildSearchableDropdown(context);
      case DropdownType.multiSelect:
        return _buildMultiSelectDropdown(context);
    }
  }

  Widget _buildBasicDropdown(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FormField<T>(
          validator: validator,
          builder: (FormFieldState<T> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: constraints.maxWidth,
                  child: DropdownButton2<T>(
                    items: _buildDropdownMenuItems(constraints.maxWidth),
                    value: value,
                    onChanged: (newValue) {
                      if (onChanged != null) {
                        onChanged!(newValue);
                      }
                      state.didChange(newValue);
                    },
                    hint: hint,
                    buttonStyleData: buttonStyleData,
                    iconStyleData: iconStyleData,
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: dropdownStyleData.maxHeight,
                      width: constraints.maxWidth,
                      padding: dropdownStyleData.padding,
                      decoration: dropdownStyleData.decoration,
                      scrollbarTheme: dropdownStyleData.scrollbarTheme,
                      openInterval: dropdownStyleData.openInterval,
                      offset: dropdownStyleData.offset,
                      isOverButton: dropdownStyleData.isOverButton,
                      useRootNavigator: dropdownStyleData.useRootNavigator,
                    ),
                    menuItemStyleData: menuItemStyleData,
                    isExpanded: true,
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSearchableDropdown(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FormField<T>(
          validator: validator,
          builder: (FormFieldState<T> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: constraints.maxWidth,
                  child: DropdownButton2<T>(
                    items: _buildDropdownMenuItems(constraints.maxWidth),
                    value: value,
                    onChanged: (newValue) {
                      if (onChanged != null) {
                        onChanged!(newValue);
                      }
                      state.didChange(newValue);
                    },
                    hint: hint,
                    buttonStyleData: buttonStyleData,
                    iconStyleData: iconStyleData,
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: dropdownStyleData.maxHeight,
                      width: constraints.maxWidth,
                      padding: dropdownStyleData.padding,
                      decoration: dropdownStyleData.decoration,
                      scrollbarTheme: dropdownStyleData.scrollbarTheme,
                      openInterval: dropdownStyleData.openInterval,
                      offset: dropdownStyleData.offset,
                      isOverButton: dropdownStyleData.isOverButton,
                      useRootNavigator: dropdownStyleData.useRootNavigator,
                    ),
                    menuItemStyleData: menuItemStyleData,
                    isExpanded: true,
                    dropdownSearchData: DropdownSearchData(
                      searchController: searchController,
                      searchInnerWidget: searchInnerWidgetFn != null
                          ? searchInnerWidgetFn!(_buildDefaultSearchWidget())
                          : _buildDefaultSearchWidget(),
                      searchInnerWidgetHeight: 50,
                      searchMatchFn: (item, searchValue) {
                        return item.value
                            .toString()
                            .toLowerCase()
                            .contains(searchValue.toLowerCase());
                      },
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildMultiSelectDropdown(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FormField<List<T>>(
          validator: multiValidator,
          builder: (FormFieldState<List<T>> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: constraints.maxWidth,
                  child: DropdownButton2<T>(
                    items: items.map((T item) {
                      final isSelected = selectedItems?.contains(item) ?? false;
                      return DropdownMenuItem<T>(
                        value: item,
                        enabled: false,
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return InkWell(
                              onTap: () {
                                final newSelection =
                                    List<T>.from(selectedItems ?? []);
                                if (isSelected) {
                                  newSelection.remove(item);
                                } else {
                                  newSelection.add(item);
                                }
                                if (onMultiChanged != null) {
                                  onMultiChanged!(newSelection);
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: isSelected,
                                        onChanged: (checked) {
                                          final newSelection =
                                              List<T>.from(selectedItems ?? []);
                                          if (checked == true) {
                                            newSelection.add(item);
                                          } else {
                                            newSelection.remove(item);
                                          }
                                          if (onMultiChanged != null) {
                                            onMultiChanged!(newSelection);
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: itemBuilder(item),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                    value: null,
                    onChanged: (_) {},
                    hint: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        selectedItems?.isEmpty ?? true
                            ? (hint ?? const Text('Select items')).toString()
                            : '${selectedItems!.length} item(s) selected',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    buttonStyleData: buttonStyleData,
                    iconStyleData: iconStyleData,
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: dropdownStyleData.maxHeight,
                      width: constraints.maxWidth,
                      padding: dropdownStyleData.padding,
                      decoration: dropdownStyleData.decoration,
                      scrollbarTheme: dropdownStyleData.scrollbarTheme,
                      openInterval: dropdownStyleData.openInterval,
                      offset: dropdownStyleData.offset,
                      isOverButton: dropdownStyleData.isOverButton,
                      useRootNavigator: dropdownStyleData.useRootNavigator,
                    ),
                    menuItemStyleData: menuItemStyleData,
                    isExpanded: true,
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  List<DropdownMenuItem<T>> _buildDropdownMenuItems(double maxWidth) {
    return items.map((T item) {
      return DropdownMenuItem<T>(
        value: item,
        child: SizedBox(
          width: maxWidth - 32,
          child: DefaultTextStyle(
            style: item == value ? selectedItemTextStyle : itemTextStyle,
            child: itemBuilder(item),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildDefaultSearchWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          hintText: 'Search for an item...',
          hintStyle: TextStyle(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
