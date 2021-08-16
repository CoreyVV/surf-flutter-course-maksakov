import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/bottom_navigation_bar.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_details.dart';

enum _State {
  history,
  empty,
  found,
}

final TextEditingController _controller = TextEditingController();
List _historyQueries = [];
_State _currentState = _State.empty;

class SightSearchScreen extends StatefulWidget {
  // const SightSearchScreen({ Key? key }) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  final FocusNode _focusNode = FocusNode();
  List _foundSight = [];

  @override
  void initState() {
    if (_historyQueries.isNotEmpty)
      _currentState = _State.history;
    else
      _currentState = _State.empty;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Список интересных мест'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                height: 40,
                child: _searchBar(context),
              ),
              if (_currentState == _State.found)
                _FoundSights(listFound: _foundSight)
              else if (_currentState == _State.empty)
                _NothingFound()
              else if (_currentState == _State.history)
                _showHistory(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }

  Widget _searchBar(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      cursorHeight: 24,
      cursorWidth: 1,
      textInputAction: TextInputAction.search,
      onChanged: (newValue) {
        _getSight();
      },
      onEditingComplete: () {
        _addHistory();
        _getSight();
      },
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
        suffixIcon: Material(
          color: Colors.transparent,
          child: IconButton(
            icon: MyIcon(
              asset: AssetsStr.icon_clear,
              color: Theme.of(context).accentColor,
            ),
            iconSize: 18,
            splashRadius: 20,
            onPressed: () {
              _controller.clear();
              _foundSight.clear();
              _historyQueries.isNotEmpty
                  ? _currentState = _State.history
                  : _currentState = _State.empty;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  _getSight() {
    if (_controller.text != '') {
      _foundSight = mocks
          .where(
            (element) => element.name.toLowerCase().contains(
                  _controller.text.trim(),
                ),
          )
          .toList();
    } else
      _foundSight.clear();
    _historyQueries.isNotEmpty
        ? _currentState = _State.history
        : _currentState = _State.empty;
    if (_foundSight.isNotEmpty) _currentState = _State.found;

    setState(() {});
  }

  _addHistory() {
    if ((_controller.text != '') &&
        (!_historyQueries.contains(_controller.text)))
      _historyQueries.add(_controller.text);
  }

  _showHistory(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 32, bottom: 4),
          child: Text(
            'ВЫ ИСКАЛИ',
            style: Theme.of(context)
                .primaryTextTheme
                .bodyText2!
                .copyWith(fontSize: 14),
          ),
        ),
        for (var i = 0; i < _historyQueries.length; i++)
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                _HistoryItem(
                  data: _historyQueries[i],
                  onPressed: (value) {
                    setState(() {
                      _historyQueries.remove(value);
                      if (_historyQueries.isEmpty) _currentState = _State.empty;
                    });
                  },
                ),
                SizedBox(
                  height: 13,
                ),
                (i != (_historyQueries.length - 1))
                    ? Divider(
                        height: 1,
                      )
                    : Container(),
              ],
            ),
          ),
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              setState(() {
                _historyQueries.clear();
                _currentState = _State.empty;
              });
            },
            child: Text('Очистить историю'),
            style: ElevatedButton.styleFrom(
                onPrimary: Theme.of(context).buttonColor),
          ),
        )
      ],
    );
  }
}

//Виджет отображения ничего не найденно
class _NothingFound extends StatelessWidget {
  // const _showError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 170,
        ),
        MyIcon(
          asset: AssetsStr.search,
          color: Theme.of(context).unselectedWidgetColor,
          height: 48,
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'Ничего не найденою',
          style: Theme.of(context).primaryTextTheme.headline6,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Попробуйте изменить параметры\nпоиска.',
          style: Theme.of(context).primaryTextTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

//Виджет отображения списка найденных мест
class _FoundSights extends StatelessWidget {
  // const _ShowFound({ Key? key }) : super(key: key);
  final List listFound;
  const _FoundSights({
    required this.listFound,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 29,
        ),
        for (var i = 0; i < listFound.length; i++)
          Column(children: [
            _Item(sight: listFound[i]),
            (i != (listFound.length - 1))
                ? Divider(
                    height: 1,
                  )
                : Container(),
          ]),
      ],
    );
  }
}

//Виджет элемента списка найденных мест
class _Item extends StatelessWidget {
  // const _Item({ Key? key }) : super(key: key);
  final Sight sight;
  const _Item({required this.sight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      width: double.infinity,
      // padding: EdgeInsets.only(top: 11),
      child: Material(
        child: InkWell(
          child: Ink(
            child: Row(
              children: [
                SizedBox(
                  height: 56,
                  width: 56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      sight.url,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sight.name),
                      SizedBox(
                        height: 8,
                      ),
                      Text(sight.type),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SightDetails(sight),
              ),
            );
          },
        ),
      ),
    );
  }
}

//Виджет элемента истории
class _HistoryItem extends StatelessWidget {
  final String data;
  Function onPressed;
  // const _HistoryItem({ Key? key }) : super(key: key);
  _HistoryItem({required this.data, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: InkWell(
              child: Container(
                width: 207,
                child: Text(
                  data,
                  maxLines: 2,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subtitle1!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              onTap: () => _controller.text = data,
            ),
          ),
          Positioned(
            top: -15,
            right: 0,
            child: IconButton(
              icon: MyIcon(
                asset: AssetsStr.delete,
                color: Theme.of(context).unselectedWidgetColor,
              ),
              splashRadius: 13,
              onPressed: () => onPressed(data),
            ),
          ),
        ],
      ),
    );
  }
}
