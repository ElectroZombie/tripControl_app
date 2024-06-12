import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:trip_control_app/models/trip_model.dart';

Widget dropDownSearch(
    paises, TextEditingController userEditTextController, context, callbacks) {
  return DropdownSearch<String>(
      onChanged: (value) => callbacks['pais'](value),
      items: paises,
      clearButtonProps: const ClearButtonProps(isVisible: true),
      popupProps: PopupProps.modalBottomSheet(
        showSelectedItems: true,
        itemBuilder: _customPopupItemBuilderExample2,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          keyboardType: TextInputType.name,
          controller: userEditTextController,
          decoration: InputDecoration(
            label: const Text("SELECCIONE EL PAÍS"),
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
            fillColor: const Color.fromARGB(92, 78, 146, 163),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                userEditTextController.clear();
              },
            ),
          ),
        ),
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        baseStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        dropdownSearchDecoration: InputDecoration(
          labelText: 'PAÍS DE DESTINO:',
          labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          border: OutlineInputBorder(borderRadius: BorderRadius.only()),
        ),
      ));
}

Widget dropDownSearchCurrent(
    paises,
    TextEditingController userEditTextController,
    TripModel trip,
    context,
    Function updatePais) {
  return DropdownSearch<String>(
      onChanged: (value) => updatePais(value, trip.tripID, context),
      items: paises,
      selectedItem: trip.nombrePais,
      clearButtonProps: const ClearButtonProps(isVisible: true),
      popupProps: PopupProps.modalBottomSheet(
        showSelectedItems: true,
        itemBuilder: _customPopupItemBuilderExample2,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          keyboardType: TextInputType.name,
          controller: userEditTextController,
          decoration: InputDecoration(
            label: const Text("SELECCIONE EL PAÍS"),
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
            fillColor: const Color.fromARGB(92, 78, 146, 163),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                userEditTextController.clear();
              },
            ),
          ),
        ),
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        baseStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        dropdownSearchDecoration: InputDecoration(
          labelText: 'PAÍS DE DESTINO:',
          labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          border: OutlineInputBorder(borderRadius: BorderRadius.only()),
        ),
      ));
}

Widget _customPopupItemBuilderExample2(
    BuildContext context, String item, bool isSelected) {
  return Container(
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: const Color.fromARGB(222, 78, 146, 163)),
            borderRadius: BorderRadius.circular(5),
          ),
    child: ListTile(
      tileColor: const Color.fromARGB(92, 83, 143, 207),
      selected: isSelected,
      title: Text(item),
    ),
  );
}
