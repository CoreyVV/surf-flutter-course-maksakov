import 'package:flutter/material.dart';
import 'package:places/ui/screens/sight_search_screen.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/res/icons.dart';

class SearchBar extends StatelessWidget {
  // const SearchBar({ Key? key }) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Stack(
        children: [
          TextField(
            controller: _controller,
            autofocus: false,
            cursorHeight: 24,
            cursorWidth: 1,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SightSearchScreen(),
                ),
              );
            },
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              fillColor: Theme.of(context).primaryColorDark,
              filled: true,
              hintText: ' Поиск',
              contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
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
                color: Theme.of(context).accentIconTheme.color,
              ),
              iconSize: 18,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => FilterScreen(),
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
