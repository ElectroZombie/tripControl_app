import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:trip_control_app/models/trip_model.dart';

Widget dropDownSearch(paises, TextEditingController userEditTextController,
    context, callbacks, ColorScheme colors, bool singleton) {
  return DropdownSearch<String>(
      onChanged: (value) => callbacks['pais'](value),
      items: paises,
      clearButtonProps: const ClearButtonProps(isVisible: true),
      popupProps: PopupProps.modalBottomSheet(
        showSelectedItems: true,
        itemBuilder: _customPopupItemBuilderExample2,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          cursorColor: colors.tertiary,
          keyboardType: TextInputType.name,
          controller: userEditTextController,
          decoration: InputDecoration(
            fillColor: colors.surfaceContainerHighest,
            focusColor: colors.tertiary,
            hoverColor: colors.surface,
            label: const Text("SELECCIONE EL DESTINO"),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: colors.tertiary,
                  width: 20,
                )),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                userEditTextController.clear();
              },
              color: colors.error,
              hoverColor: colors.surfaceContainerHighest,
            ),
          ),
        ),
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: 'SELECCIONE EL DESTINO:',
        ),
      ));
}

Widget dropDownSearchCurrent(
    paises,
    TextEditingController userEditTextController,
    TripModel trip,
    context,
    Function updatePais,
    ColorScheme colors,
    bool singleton) {
  return DropdownSearch<String>(
    onChanged: (value) => updatePais(value, trip, context, singleton),
    items: paises,
    selectedItem: trip.nombrePais,
    clearButtonProps: const ClearButtonProps(isVisible: true),
    popupProps: PopupProps.modalBottomSheet(
      showSelectedItems: true,
      itemBuilder: _customPopupItemBuilderExample2,
      showSearchBox: true,
      searchFieldProps: TextFieldProps(
        cursorColor: colors.tertiary,
        keyboardType: TextInputType.name,
        controller: userEditTextController,
        decoration: InputDecoration(
          fillColor: colors.surfaceContainerHighest,
          focusColor: colors.tertiary,
          hoverColor: colors.primary,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: colors.tertiary)),
          suffixIcon: IconButton(
            color: colors.error,
            hoverColor: colors.surfaceContainerHighest,
            icon: const Icon(Icons.clear),
            onPressed: () {
              userEditTextController.clear();
            },
          ),
        ),
      ),
    ),
    dropdownDecoratorProps: const DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        labelText: 'PAÍS DE DESTINO:',
      ),
    ),
  );
}

Widget _customPopupItemBuilderExample2(
    BuildContext context, String item, bool isSelected) {
  ColorScheme colors = Theme.of(context).colorScheme;
  return Container(
    decoration: !isSelected
        ? null
        : BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
    child: ListTile(
      tileColor: colors.surfaceContainerHighest,
      selectedColor: colors.onSecondary,
      selectedTileColor: colors.secondary,
      textColor: colors.onPrimary,
      selected: isSelected,
      title: Text(item, style: const TextStyle(fontSize: 16)),
    ),
  );
}
