import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class NativeDropdown<T> extends StatelessWidget {
  NativeDropdown({
    super.key,
    required this.items,
    this.maxItems,
    this.textStyle,
    this.hintText,
    this.value,
    required this.onChanged,
    this.searchController,
  });
  final List<DropdownMenuItem<T>>? items;
  final String? hintText;
  final int? maxItems;
  final TextStyle? textStyle;
  final List<T>? value;
  final ValueChanged<List<T>> onChanged;
  final TextEditingController? searchController;
  final MultiSelectController<T> _controller = MultiSelectController();
  @override
  Widget build(BuildContext context) {
    // return DropdownButtonHideUnderline(
    //   child: DropdownButton2<T>(
    //     isExpanded: true,
    //     hint: NativeSmallTitleText(
    //       hintText ?? 'Select',
    //       color: ColorUtils.textGrey.withOpacity(0.4),
    //     ),
    //     items: items,
    //     value: value,
    //     onChanged: onChanged,
    //     iconStyleData: IconStyleData(
    //       icon: const Icon(Icons.keyboard_arrow_down),
    //       iconEnabledColor: ColorUtils.textLightGrey.withOpacity(0.5),
    //     ),
    //     buttonStyleData: ButtonStyleData(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(4),
    //         color: ColorUtils.textLightGrey.withOpacity(0.05),
    //       ),
    //       padding: const EdgeInsets.symmetric(horizontal: 16),
    //       height: 56,
    //       // width: 200,
    //     ),
    //     dropdownStyleData: const DropdownStyleData(
    //       maxHeight: 200,
    //       elevation: 2,
    //     ),
    //     menuItemStyleData: const MenuItemStyleData(
    //       height: 40,
    //     ),
    //     dropdownSearchData: searchController != null
    //         ? DropdownSearchData(
    //             searchController: searchController,
    //             searchInnerWidgetHeight: 50,
    //             searchInnerWidget: Container(
    //               height: 50,
    //               color: ColorUtils.textLightGrey.withOpacity(0.05),
    //               padding: const EdgeInsets.only(
    //                   top: 8, bottom: 4, right: 8, left: 8),
    //               child: NativeTextField(
    //                 searchController,
    //                 hintText: 'Search',
    //                 prefixIcon: Icon(
    //                   CupertinoIcons.search,
    //                   color: ColorUtils.textLightGrey.withOpacity(0.5),
    //                 ),
    //               ),
    //             ),
    //             searchMatchFn: (item, searchValue) {
    //               return item.value
    //                   .toString()
    //                   .toLowerCase()
    //                   .contains(searchValue.toLowerCase());
    //             },
    //           )
    //         : null,
    //     //This to clear the search value when you close the menu
    //     onMenuStateChange: (isOpen) {
    //       if (!isOpen) {
    //         searchController?.clear();
    //       }
    //     },
    //   ),
    // );
    _controller.setOptions(
      items!
          .map((e) => ValueItem(label: e.value.toString(), value: e.value as T))
          .toList(),
    );
    _controller.setSelectedOptions(value != null
        ? value!.map((e) => ValueItem(label: e.toString(), value: e)).toList()
        : []);
    return MultiSelectDropDown<T>(
      dropdownMargin: 8,
      showClearIcon: false,
      controller: _controller,
      onOptionSelected: (options) {
        options.removeWhere((e) => e.value == null);
        // (options as List<ValueItem<Object>>).map((e) => e.value as T).toList();
        onChanged(options.map((e) => e.value as T).toList());
      },
      options: items!
          .map((e) => ValueItem(label: e.value.toString(), value: e.value as T))
          .toList(),
      maxItems: maxItems ?? 1,
      selectionType: maxItems == 1 ? SelectionType.single : SelectionType.multi,
      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
      dropdownHeight: 200,
      optionTextStyle: textStyle ?? const TextStyle(fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
      // selectedOptions: value != null
      //     ? value!.map((e) => ValueItem(label: e.toString(), value: e)).toList()
      //     : [],
      // TODO: Need to fix the dropdown be covered by soft-keyboard when using search
      // searchEnabled: true,
    );
  }
}
