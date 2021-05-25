import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                height: 132,
                color: Colors.blue,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        sight.type,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    Expanded(child: FittedBox()),
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                height: 92,
                color: Color(0xFFF5F5F5),
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 328),
                        child: Text(
                          sight.name,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 328),
                        child: Text(
                          sight.details,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
