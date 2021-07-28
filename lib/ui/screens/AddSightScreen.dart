import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/res/icons.dart';

String _selectedType = SightType.museum;
String _name = '';
double _long = 0.0;
double _lat = 0.0;
String _desc = '';
String _url =
    'https://i.pinimg.com/originals/1c/6c/ce/1c6ccec971aa1a9721c7fc7ee275ef95.jpg';

class _SightType {
  final String type;
  final String title;

  _SightType({
    required this.title,
    required this.type,
  });

  @override
  String toString() {
    return this.title;
  }
}

//типы мест
final _sightTypeCafe = _SightType(
  title: 'Кафе',
  type: SightType.cafe,
);
final _sightTypeHotel = _SightType(
  title: 'Отель',
  type: SightType.hotel,
);
final _sightTypeMuseum = _SightType(
  title: 'Музей',
  type: SightType.museum,
);
final _sightTypePark = _SightType(
  title: 'Парк',
  type: SightType.park,
);
final _sightTypeParticularPlace = _SightType(
  title: 'Особое место',
  type: SightType.particular_place,
);
final _sightTypeRestourant = _SightType(
  title: 'Ресторан',
  type: SightType.restourant,
);

//храним значение фильтров
Map<_SightType, bool> _typesMap = {
  _sightTypeCafe: false,
  _sightTypeHotel: false,
  _sightTypeMuseum: false,
  _sightTypePark: false,
  _sightTypeParticularPlace: false,
  _sightTypeRestourant: false,
};

bool checkSight() =>
    (_selectedType.isNotEmpty && _name.isNotEmpty && _desc.isNotEmpty)
        ? true
        : false;

//экран добавления нового места
class AddSightScreen extends StatefulWidget {
  // const AddSightScreen({Key? key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: _NewSightBody(),
    );
  }
}

//AppBar экрана добавления нового места
class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  // const _AppBar({Key? key}) : super(key: key);
  final double height;
  _AppBar({this.height = 56});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 18, bottom: 18),
          child: Row(
            children: [
              Material(
                child: InkWell(
                  child: Ink(
                    child: Text(
                      'Отмена',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).primaryTextTheme.subtitle1,
                    ),
                  ),
                  onTap: () {
                    print('AddSightScreen/Cancel was tapped');
                  },
                ),
              ),
              SizedBox(
                width: 51,
              ),
              Text(
                'Новое место',
                textAlign: TextAlign.center,
                style: Theme.of(context).accentTextTheme.headline6,
              ),
            ],
          ),
        ),
      ),
      toolbarHeight: height,
    );
  }
}

//Body экрана добавления нового места
class _NewSightBody extends StatelessWidget {
  // const _NewSightBody({ Key? key }) : super(key: key);
  final FocusNode _focusNodeName = new FocusNode();
  final FocusNode _focusNodeLat = new FocusNode();
  final FocusNode _focusNodeLon = new FocusNode();
  final FocusNode _focusNodeDesc = new FocusNode();
  final FocusNode _focusNodeSave = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 16,
              top: 24,
              right: 24,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Категория',
                    style:
                        Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                              fontSize: 12,
                            ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Не выбрано',
                      style: Theme.of(context).primaryTextTheme.bodyText2,
                    ),
                    Expanded(child: Container()),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          print('AddSightScreen/Category was tapped');
                        },
                        icon: MyIcon(
                          asset: AssetsStr.icon_view,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.8,
                        color: Theme.of(context)
                            .unselectedWidgetColor
                            .withOpacity(0.56),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
            child: _InputBox(
              title: 'НАЗВАНИЕ',
              focusNode: _focusNodeName,
              focusNodeNext: _focusNodeLat,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
                child: SizedBox(
                  width: 172,
                  child: _InputBox(
                    title: 'ШИРОТА',
                    focusNode: _focusNodeLat,
                    focusNodeNext: _focusNodeLon,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, right: 16),
                child: SizedBox(
                  width: 172,
                  child: _InputBox(
                    title: 'ДОЛГОТА',
                    focusNode: _focusNodeLon,
                    focusNodeNext: _focusNodeDesc,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            height: 48,
            child: TextButton(
              child: Text('Указать на карте'),
              style: ElevatedButton.styleFrom(
                  onPrimary: Theme.of(context).buttonColor),
              onPressed: () {
                print('AddSightScreen\Location button was tapped');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
            child: _InputBox(
              title: 'ОПИСАНИЕ',
              focusNode: _focusNodeDesc,
              focusNodeNext: _focusNodeSave,
              maxLines: 4,
              action: TextInputAction.done,
            ),
          ),
          SizedBox(
            height: 116,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 64,
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: ElevatedButton(
                child: Text('Создать'),
                onPressed: () {
                  print('AddSightScreen\Create button was tapped');
                  checkSight()
                      ? mocks.add(Sight(
                          name: _name,
                          lat: _lat,
                          lon: _long,
                          url: _url,
                          details: _desc,
                          type: _selectedType))
                      : null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//TextField
class _InputBox extends StatefulWidget {
  // const _InputBox({Key? key}) : super(key: key);
  final String title;
  final FocusNode focusNode;
  final FocusNode focusNodeNext;
  final int maxLines;
  final TextInputAction action;
  final TextInputType keyboardType;
  var value;

  _InputBox({
    required this.title,
    required this.focusNode,
    required this.focusNodeNext,
    this.maxLines = 1,
    this.action = TextInputAction.next,
    this.keyboardType = TextInputType.text,
  });

  @override
  __InputBoxState createState() =>
      __InputBoxState(this.focusNode, this.focusNodeNext);
}

class __InputBoxState extends State<_InputBox> {
  final TextEditingController _controller = new TextEditingController();
  final FocusNode focusNode;
  final FocusNode focusNodeNext;

  __InputBoxState(this.focusNode, this.focusNodeNext);

  @override
  void initState() {
    super.initState();
    //var _focusNode = widget.focusNode;
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
              bottom: 12,
            ),
            child: Text(
              widget.title,
              style: Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                    fontSize: 12,
                  ),
            ),
          ),
          TextFormField(
            controller: _controller,
            focusNode: focusNode,
            maxLines: widget.maxLines,
            textInputAction: widget.action,
            keyboardType: widget.keyboardType,
            autofocus: true,
            cursorHeight: 24,
            cursorWidth: 1,
            cursorColor: Theme.of(context).textTheme.bodyText1!.color,
            onChanged: (newValue) {
              setState(() {});
            },
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(focusNodeNext);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              suffixIcon: focusNode.hasFocus && _controller.text.isNotEmpty
                  ? IconButton(
                      icon: MyIcon(
                        asset: AssetsStr.icon_clear,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

//Экран выбора типа места
class SelectSightType extends StatefulWidget {
  // const SelectSightType({ Key? key }) : super(key: key);

  @override
  _SelectSightTypeState createState() => _SelectSightTypeState();
}

class _SelectSightTypeState extends State<SelectSightType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBarSightType(),
      body: ListView(
        children: [
          for (_SightType sight in _typesMap.keys)
            _TypeFilterBox(
              onTap: () {
                setState(() {
                  bool s = _typesMap[sight]!;
                  _typesMap.updateAll((key, value) => false);
                  _typesMap[sight] = !s;
                  print('AddSightScreen/SelectSightType/category was tapped');
                });
              },
              sightType: sight,
            ),
        ],
      ),
      bottomSheet: Container(
        height: 64,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 64,
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ElevatedButton(
              child: Text('Сохранить'),
              onPressed: () {
                print('AddSightScreen/SelectSightType/save button was tapped');
              },
            ),
          ),
        ),
      ),
    );
  }
}

//AppBar экрана выбора типа нового места
class _AppBarSightType extends StatelessWidget implements PreferredSizeWidget {
  // const _AppBar({Key? key}) : super(key: key);
  final double height;
  _AppBarSightType({this.height = 56});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          splashRadius: 28,
          onPressed: () {
            print('AddSightScreen/SelectSightType/back was tapped');
          },
          icon: MyIcon(asset: AssetsStr.icon_arrow)),
      title: Row(
        children: [
          SizedBox(
            width: 88,
          ),
          Container(
            alignment: Alignment.centerLeft,
            // padding: const EdgeInsets.only(left: 16, top: 18, bottom: 18),
            child: Text(
              'Категория',
              textAlign: TextAlign.center,
              style: Theme.of(context).accentTextTheme.headline6,
            ),
          ),
        ],
      ),
      toolbarHeight: height,
    );
  }
}

//Элемент отображающий категорию
class _TypeFilterBox extends StatelessWidget {
  // const TypeFilterBox({ Key? key }) : super(key: key);

  // final SightTypeIcon sightTypeIcon;
  final void Function() onTap;
  final _SightType sightType;
  // bool isSelected = false;

  _TypeFilterBox({
    // required this.sightTypeIcon,
    required this.onTap,
    required this.sightType,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          child: InkWell(
            onTap: onTap,
            child: Ink(
              child: Container(
                padding: EdgeInsets.only(left: 16),
                alignment: Alignment.centerLeft,
                height: 48,
                width: double.infinity,
                color: Colors.transparent,
                child: Text(
                  sightType.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ),
        ),
        if (_typesMap[sightType]!)
          Positioned(
            right: 20,
            bottom: 12,
            child: MyIcon(
              asset: AssetsStr.icon_tick,
              color: Theme.of(context).accentIconTheme.color,
            ),
          ),
      ],
    );
  }
}