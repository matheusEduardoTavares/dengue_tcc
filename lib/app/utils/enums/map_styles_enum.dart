import 'package:flutter/material.dart';

enum MapStylesEnum {
  DARK(
    title: 'Escuro',
    style: 'dark-v10',
    iconData: Icons.nightlight_round,
  ),
  LIGHT(
    title: 'Claro',
    style: 'light-v10',
    iconData: Icons.wb_sunny,
  ),
  SATELLITE(
    title: 'Satélite',
    style: 'satellite-v9',
    iconData: Icons.satellite,
  ),
  STREET(
    title: 'Padrão',
    style: 'streets-v11',
    iconData: Icons.streetview,
  );

  final String title;
  final String style;
  final IconData iconData;

  const MapStylesEnum({
    required this.title,
    required this.style,
    required this.iconData,
  });
}
