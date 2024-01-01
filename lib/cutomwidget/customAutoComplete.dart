import 'package:flutter/material.dart';

class MyAutocomplete<T extends Object> extends StatelessWidget {
  final Iterable<T> Function(TextEditingValue) optionsBuilder;
  final void Function(T) onSelected;
  final Widget Function(
          BuildContext, TextEditingController, FocusNode, VoidCallback)
      fieldViewBuilder;
  final Widget Function(BuildContext, void Function(T), Iterable<T>)
      optionsViewBuilder;

  MyAutocomplete({
    required this.optionsBuilder,
    required this.onSelected,
    required this.fieldViewBuilder,
    required this.optionsViewBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return Iterable<T>.empty();
        } else {
          List<T> matches = optionsBuilder(textEditingValue).toList();
          return matches;
        }
      },
      onSelected: (T selection) {
        onSelected(selection);
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return fieldViewBuilder(
            context, textEditingController, focusNode, onFieldSubmitted);
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<T> onSelected,
        Iterable<T> options,
      ) {
        return optionsViewBuilder(context, onSelected, options);
      },
    );
  }
}
