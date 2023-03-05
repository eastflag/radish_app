import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:radish_app/input/category_input_screen.dart';
import 'package:radish_app/input/input_screen.dart';
import 'package:radish_app/screens/home_screen.dart';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [BeamPage(child: HomeScreen(), key: ValueKey('home'))];
  }

  @override
  List get pathBlueprints => ['/'];
}

class InputLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if (state.pathBlueprintSegments.contains('input'))
        BeamPage(
            child: InputScreen(),
            key: ValueKey('input')),
      if (state.pathBlueprintSegments.contains('category_input'))
        BeamPage(
            child: CategoryInputScreen(),
            key: ValueKey('category_input'))
    ];
  }

  @override
  List get pathBlueprints => ['/input', '/input/category_input'];
}
