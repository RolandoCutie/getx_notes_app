import 'package:flutter/widgets.dart';
import 'package:getx_notes_app/app/core/values/colors.dart';
import 'package:getx_notes_app/app/core/values/icons.dart';

List<Icon> getIcons() {
  return const [
    Icon(IconData(personIcon, fontFamily: 'MaterialIcons'),
        size: 28, color: purple),
    Icon(IconData(workIcon, fontFamily: 'MaterialIcons'),
        size: 28, color: pink),
    Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'),
        size: 28, color: green),
    Icon(IconData(sportIcon, fontFamily: 'MaterialIcons'),
        size: 28, color: yellow),
    Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'),
        size: 28, color: deepPink),
    Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'),
        size: 28, color: lightBlue),
  ];
}
