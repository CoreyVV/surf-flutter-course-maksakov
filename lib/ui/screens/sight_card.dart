import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_details.dart';
import 'package:places/ui/screens/widgets/loading_builder.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({
    required this.sight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: double.infinity,
        height: 188,
        child: Stack(
          children: [
            _Base(
              sight: sight,
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.hardEdge,
              child: Ink(
                child: InkWell(
                  highlightColor: greenWhite.withOpacity(0.24),
                  splashColor: greenWhite.withOpacity(0.12),
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SightDetails(
                          id: sight.id,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                sight.type,
                style: Theme.of(context).accentTextTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
              ),
            ),
            Positioned(
              top: 19,
              right: 18,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  highlightColor: greenWhite.withOpacity(0.24),
                  splashColor: greenWhite.withOpacity(0.12),
                  onTap: () {
                   print('SightCard/iconHeart was tapped');
                  },
                  child: Ink(
                    child: const MyIcon(
                      asset: AssetsStr.iconHeart,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Base extends StatelessWidget {
  final Sight sight;

  const _Base({
    required this.sight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 96,
          child: Image.network(
            sight.url,
            loadingBuilder: loadingBuilder,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          height: 92,
          color: Theme.of(context).primaryColorDark,
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 328),
                  child: Text(
                    sight.name,
                    maxLines: 2,
                    style: Theme.of(context).accentTextTheme.bodyText1,
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 328),
                  child: Text(
                    sight.details,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
