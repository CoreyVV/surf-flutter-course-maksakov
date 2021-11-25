import 'package:flutter/material.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/res/app_strings.dart';
import 'package:places/ui/screens/res/my_icons.dart';
import 'package:places/ui/screens/sight_search_screen.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          TextField(
            controller: _controller,
            cursorHeight: 24,
            cursorWidth: 1,
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (_) => const SightSearchScreen(),
                ),
              );
            },
            readOnly: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              fillColor: Theme.of(context).primaryColorDark,
              filled: true,
              hintText: AppStrings.searchBarHintText,
              contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              prefixIcon: MyIcon(
                asset: AssetsStr.search,
                color: Theme.of(context).unselectedWidgetColor,
                height: 18,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Positioned(
            bottom: -4,
            right: 15,
            child: IconButton(
              icon: MyIcon(
                asset: AssetsStr.filter,
                color: Theme.of(context).colorScheme.secondary,
              ),
              iconSize: 18,
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FiltersScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
