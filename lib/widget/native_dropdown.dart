import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/native_text_field.dart';
import 'package:native/widget/text/native_small_title_text.dart';

class NativeDropdown<T> extends StatelessWidget {
  const NativeDropdown({super.key, required this.items, this.hintText, this.value, required this.onChanged, this.searchController});
  final List<DropdownMenuItem<T>>? items;
  final String? hintText;
  final T? value;
  final ValueChanged<T?> onChanged;
  final TextEditingController? searchController;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint: NativeSmallTitleText(
          hintText ?? 'Select',
          color: ColorUtils.textGrey.withOpacity(0.4),
        ),
        items: items,
        value: value,
        onChanged: onChanged,
        iconStyleData: IconStyleData(
          icon: const Icon(Icons.keyboard_arrow_down),
          iconEnabledColor: ColorUtils.textLightGrey.withOpacity(0.5),
        ),
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: ColorUtils.textLightGrey.withOpacity(0.05),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 56,
          // width: 200,
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 200,
          elevation: 2,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: searchController != null
            ? DropdownSearchData(
                searchController: searchController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  color: ColorUtils.textLightGrey.withOpacity(0.05),
                  padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
                  child: NativeTextField(
                    searchController,
                    hintText: 'Search',
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: ColorUtils.textLightGrey.withOpacity(0.5),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
                },
              )
            : null,
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchController?.clear();
          }
        },
      ),
    );
  }
}
