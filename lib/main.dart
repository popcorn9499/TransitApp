import 'package:flutter/material.dart';
import 'package:transit_app/widgets/menus/main_menu.dart';

import 'Config/favorite_manager.dart';

void main() {
  FavoriteManager fm = FavoriteManager();
  runApp(MainMenu(fm: fm));

}






