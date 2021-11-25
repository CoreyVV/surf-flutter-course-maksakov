import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/res/app_strings.dart';
import 'package:places/ui/screens/res/my_icons.dart';

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
    return title;
  }
}

//типы мест
final _sightTypeCafe = _SightType(
  title: AppStrings.sightTypeCafeTitle,
  type: SightType.cafe,
);
final _sightTypeHotel = _SightType(
  title: AppStrings.sightTypeHotelTitle,
  type: SightType.hotel,
);
final _sightTypeMuseum = _SightType(
  title: AppStrings.sightTypeMuseumTitle,
  type: SightType.museum,
);
final _sightTypePark = _SightType(
  title: AppStrings.sightTypeParkTitle,
  type: SightType.park,
);
final _sightTypeParticularPlace = _SightType(
  title: AppStrings.sightTypeParticularPlaceTitle,
  type: SightType.particularPlace,
);
final _sightTypeRestaurant = _SightType(
  title: AppStrings.sightTypeRestaurantTitle,
  type: SightType.restaurant,
);
//TODO: убрать после доработки выбора фотографий
List<String> _imagesList = [
  'https://cdn.theatlantic.com/thumbor/gHSN4W8eC4AnkdqA-v7NJUABcBo=/1500x1001/media/img/photo/2016/09/the-beauty-of-terraced-fields/t01_82594302/original.jpg',
  'https://cdn.theatlantic.com/thumbor/jlBbH8ql4PADBerveJ9yyWJZLU0=/1500x908/media/img/photo/2016/09/the-beauty-of-terraced-fields/t02_154921930/original.jpg',
  'https://cdn.theatlantic.com/thumbor/62twl5RYxffj8l5YUMiOoMMKJhE=/1500x834/media/img/photo/2016/09/the-beauty-of-terraced-fields/t05_RTS2ZQM/original.jpg',
  'https://cdn.theatlantic.com/thumbor/RR4kX56okPh66ol7XMs0-gJwvq0=/1500x1041/media/img/photo/2016/09/the-beauty-of-terraced-fields/t14_AP614457396093/original.jpg',
  'https://cdn.theatlantic.com/thumbor/x8eCTMMqX65_ukNTZxFVGnD6V38=/1500x1001/media/img/photo/2016/09/the-beauty-of-terraced-fields/t23_RTR1ZJD7/original.jpg',
];

//храним значение фильтров
Map<_SightType, bool> _typesMap = {
  _sightTypeCafe: false,
  _sightTypeHotel: false,
  _sightTypeMuseum: false,
  _sightTypePark: false,
  _sightTypeParticularPlace: false,
  _sightTypeRestaurant: false,
};

bool checkSight() =>
    _selectedType.isNotEmpty && _name.isNotEmpty && _desc.isNotEmpty;

//экран добавления нового места
class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: _NewSightBody(),
    );
  }
}

//AppBar экрана добавления нового места
class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const _AppBar({
    this.height = 56,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 16, top: 18, bottom: 18),
        child: Row(
          children: [
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Ink(
                  child: Text(
                    'Отмена',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.subtitle1,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 51,
            ),
            Text(
              AppStrings.newSightButtonText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
      automaticallyImplyLeading: false,
      toolbarHeight: height,
    );
  }
}

//Body экрана добавления нового места
class _NewSightBody extends StatelessWidget {
  const _NewSightBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 24,
            ),
            child: Column(
              children: [
                _ImagesRow(),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppStrings.category,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 12,
                        ),
                  ),
                ),
                const _CategoryChoice(),
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
          _InputBoxes(),
          const SizedBox(
            height: 116,
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: _CreateButton(),
          ),
        ],
      ),
    );
  }
}

//Выбор категории на экране добавления нового места
class _CategoryChoice extends StatelessWidget {
  const _CategoryChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppStrings.notChosen,
          style: Theme.of(context).primaryTextTheme.bodyText2,
        ),
        Expanded(child: Container()),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              //TODO: убрать print
              print('AddSightScreen/Category was tapped');
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (_) => const SelectSightType(),
                ),
              );
            },
            icon: MyIcon(
              asset: AssetsStr.iconView,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
        ),
      ],
    );
  }
}

// Группа полей ввода экрана добавления нового места
class _InputBoxes extends StatelessWidget {
  final FocusNode _focusNodeName = FocusNode();
  final FocusNode _focusNodeLat = FocusNode();
  final FocusNode _focusNodeLon = FocusNode();
  final FocusNode _focusNodeDesc = FocusNode();
  final FocusNode _focusNodeSave = FocusNode();

  _InputBoxes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  title: AppStrings.latitudeUppercase,
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
                  title: AppStrings.longitudeUppercase,
                  focusNode: _focusNodeLon,
                  focusNodeNext: _focusNodeDesc,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ],
        ),
        const _LocationButton(),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
          child: _InputBox(
            title: AppStrings.descriptionUppercase,
            focusNode: _focusNodeDesc,
            focusNodeNext: _focusNodeSave,
            maxLines: 4,
            action: TextInputAction.done,
          ),
        ),
      ],
    );
  }
}

class _LocationButton extends StatelessWidget {
  const _LocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      alignment: Alignment.centerLeft,
      height: 48,
      child: TextButton(
        // style: ElevatedButton.styleFrom(
        //   onPrimary: Theme.of(context).buttonColor,
        // ),
        onPressed: () {
          //TODO: убрать print
          print('AddSightScreen/Location button was tapped');
        },
        child: const Text(AppStrings.markOnMap),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: ElevatedButton(
        onPressed: () => _onPressed(context),
        child: const Text(AppStrings.create),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    //TODO: убрать print
    print('AddSightScreen/Create button was tapped');
    if (checkSight()) {
      mocks.add(
        Sight(
          name: _name,
          lat: _lat,
          lon: _long,
          url: _url,
          images: [],
          details: _desc,
          type: _selectedType,
        ),
      );
    }
    Navigator.of(context).pop();
  }
}

//TextField
class _InputBox extends StatefulWidget {
  final String title;
  final FocusNode focusNode;
  final FocusNode focusNodeNext;
  final int maxLines;
  final TextInputAction action;
  final TextInputType keyboardType;

  // var value;

  const _InputBox({
    required this.title,
    required this.focusNode,
    required this.focusNodeNext,
    this.maxLines = 1,
    this.action = TextInputAction.next,
    this.keyboardType = TextInputType.text,
  });

  @override
  __InputBoxState createState() => __InputBoxState();
}

class __InputBoxState extends State<_InputBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(
            bottom: 12,
          ),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 12,
                ),
          ),
        ),
        TextFormField(
          controller: _controller,
          focusNode: widget.focusNode,
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
            FocusScope.of(context).requestFocus(widget.focusNodeNext);
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            suffixIcon: widget.focusNode.hasFocus && _controller.text.isNotEmpty
                ? IconButton(
                    icon: MyIcon(
                      asset: AssetsStr.iconClear,
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
    );
  }
}

//Экран выбора типа места
class SelectSightType extends StatefulWidget {
  const SelectSightType({Key? key}) : super(key: key);

  @override
  _SelectSightTypeState createState() => _SelectSightTypeState();
}

class _SelectSightTypeState extends State<SelectSightType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBarSightType(),
      body: ListView(
        children: [
          for (_SightType sight in _typesMap.keys)
            _TypeFilterBox(
              onTap: () {
                setState(() {
                  final s = _typesMap[sight]!;
                  _typesMap.updateAll((key, value) => false);
                  _typesMap[sight] = !s;
                  //TODO: убрать print
                  print('AddSightScreen/SelectSightType/category was tapped');
                });
              },
              sightType: sight,
            ),
        ],
      ),
      bottomSheet: SizedBox(
        height: 64,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 64,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                //TODO: убрать print
                print('AddSightScreen/SelectSightType/save button was tapped');
              },
              child: const Text(AppStrings.save),
            ),
          ),
        ),
      ),
    );
  }
}

//AppBar экрана выбора типа нового места
class _AppBarSightType extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const _AppBarSightType({
    this.height = 56,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        splashRadius: 28,
        onPressed: () {
          //TODO: убрать print
          print('AddSightScreen/SelectSightType/back was tapped');
          Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (_) => const AddSightScreen(),
            ),
          );
        },
        icon: const MyIcon(asset: AssetsStr.iconArrow),
      ),
      title: Row(
        children: [
          const SizedBox(
            width: 88,
          ),
          Container(
            alignment: Alignment.centerLeft,
            // padding: const EdgeInsets.only(left: 16, top: 18, bottom: 18),
            child: Text(
              AppStrings.category,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
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

  const _TypeFilterBox({
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
                padding: const EdgeInsets.only(left: 16),
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
              asset: AssetsStr.iconTick,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
      ],
    );
  }
}

//виджет для добавления отображения изображений места
class _ImagesRow extends StatefulWidget {
  // const _ImagesRow({ Key? key }) : super(key: key);

  @override
  __ImagesRowState createState() => __ImagesRowState();
}

class __ImagesRowState extends State<_ImagesRow> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 96,
        width: 360,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _imagesList.length + 1,
          itemBuilder: (context, index) {
            return index == 0
                ? Container(
                    margin: const EdgeInsets.only(top: 24),
                    width: 72,
                    height: 72,
                    // padding: EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (_) {
                            return const _PhotoSelectDialog();
                          },
                        );
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: MyIcon(
                        asset: AssetsStr.buttonWhitePlus,
                        color: Theme.of(context).secondaryHeaderColor,
                        // height: 72,
                        // fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 24),
                    child: _ImageRowItem(
                      url: _imagesList[index - 1],
                      onRemove: () {
                        setState(
                          () {
                            _imagesList.remove(_imagesList[index - 1]);
                          },
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class _ImageRowItem extends StatelessWidget {
  final String url;
  final void Function() onRemove;

  const _ImageRowItem({
    required this.url,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(url),
      onDismissed: (details) {
        onRemove();
      },
      direction: DismissDirection.up,
      child: SizedBox(
        width: 72,
        height: 72,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Stack(
            children: [
              // Dismissible(key: key, child: child);
              Image.network(
                url,
                // loadingBuilder: loadingBuilder,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                top: 3,
                right: 3,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    onTap: onRemove,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.transparent,
                      ),
                      child: const MyIcon(
                        asset: AssetsStr.iconClear,
                      ),
                      // width: 24,
                      // height: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoSelectDialog extends StatelessWidget {
  const _PhotoSelectDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Container(
                height: 152,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _DialogCameraButton(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.57),
                      child: Divider(
                        height: 1,
                        color: Theme.of(context)
                            .unselectedWidgetColor
                            .withOpacity(0.56),
                        thickness: 0.56,
                      ),
                    ),
                    const _DialogPhotoButton(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.57),
                      child: Divider(
                        height: 1,
                        color: Theme.of(context)
                            .unselectedWidgetColor
                            .withOpacity(0.56),
                        thickness: 0.56,
                      ),
                    ),
                    const _DialogFileButton(),
                  ],
                ),
              ),
            ),
            const _DialogCancelButton(),
          ],
        ),
      ),
    );
  }
}

class _DialogCameraButton extends StatelessWidget {
  const _DialogCameraButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          //TODO: убрать print
          print('DialogCameraButton was tapped');
        },
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 13),
                child: MyIcon(
                  asset: AssetsStr.iconCamera,
                  color: Theme.of(context).unselectedWidgetColor,
                ),
              ),
              Text(
                AppStrings.camera,
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogPhotoButton extends StatelessWidget {
  const _DialogPhotoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          //TODO: убрать print
          print('DialogPhotoButton was tapped');
        },
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 13),
                child: MyIcon(
                  asset: AssetsStr.iconPhoto,
                  color: Theme.of(context).unselectedWidgetColor,
                ),
              ),
              Text(
                AppStrings.photo,
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogFileButton extends StatelessWidget {
  const _DialogFileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          //TODO: убрать print
          print('DialogFileButton was tapped');
        },
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 17, right: 13),
                child: MyIcon(
                  asset: AssetsStr.iconFail,
                  color: Theme.of(context).unselectedWidgetColor,
                ),
              ),
              Text(
                AppStrings.file,
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DialogCancelButton extends StatelessWidget {
  const _DialogCancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: 48,
          width: 360,
          color: Theme.of(context).primaryColor,
          child: TextButton(
            // style: ElevatedButton.styleFrom(
            //   onPrimary: Theme.of(context).buttonColor,
            // ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(AppStrings.cancelUppercase),
          ),
        ),
      ),
    );
  }
}
