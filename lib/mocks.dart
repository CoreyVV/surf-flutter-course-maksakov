import 'package:places/domain/sight.dart';

final List<Sight> mocks = [
  Sight(
    id: '0000',
    name: 'Watkins Glen State Park',
    lat: 42.373537146218,
    lon: -76.88910484314,
    url:
        'https://cdn11.bigcommerce.com/s-b4g395tyji/images/stencil/2000x2000/products/715/972/17-27__76825.1549493540.jpg',
    images: [
      'https://cdn11.bigcommerce.com/s-b4g395tyji/images/stencil/2000x2000/products/715/972/17-27__76825.1549493540.jpg',
      'https://gothiceves.b-cdn.net/wp-content/uploads/2019/06/bigstock-Long-Exposure-Photo-Of-The-Wat-277944049.jpg',
      'https://www.gofingerlakes.org/wp-content/uploads/20-DSC_3430.jpg',
      'https://www.wideopenroads.com/wp-content/uploads/2021/03/AdobeStock_403498326-scaled.jpeg',
      'https://assets.simpleviewinc.com/simpleview/image/upload/crm/fingerlakesny/Watkins_Glen_2_7bd7cd00-2640-4a78-92e7-e8c99813362a0-54f7ca30a59fadc_b61dfae1-5056-a36a-0932ef048077c68f.jpg',
    ],
    details:
        'A series of waterfalls and gorges. You will certainly enjoy hiking in the Glen gorge along the stream and admiring the 19 waterfalls along its course. You can also opt for a hike on the gorge rim for breathtaking views from above!',
    type: SightType.park,
    isVisited: true,
    isPlanned: false,
  ),
  Sight(
    id: '0001',
    name: 'Mù Cang Chải',
    lat: 21.8528313,
    lon: 104.0836104,
    url:
        'https://media.hearstapps.com/hmg-prod/images/hbz-mu-cang-chai-gettyimages-625247432-1505338864.jpg',
    images: [],
    details: 'Terraced fields.',
    type: SightType.park,
    isVisited: true,
    isPlanned: false,
  ),
  Sight(
    id: '0002',
    name: 'Bagan',
    lat: 21.166666,
    lon: 94.8833298,
    url:
        'https://windows10spotlight.com/wp-content/uploads/2019/12/a2c93088f3755e1fdd94a974cc4a06a5-768x432.jpg',
    images: [],
    details: 'An ancient city.',
    type: SightType.museum,
    isVisited: true,
    isPlanned: false,
  ),
  Sight(
    id: '0003',
    name: 'Test',
    lat: 37.4515504,
    lon: -122.054032,
    url:
        'https://windows10spotlight.com/wp-content/uploads/2019/12/a2c93088f3755e1fdd94a974cc4a06a5-768x432.jpg',
    details: 'Test location.',
    images: [],
    type: SightType.park,
    isVisited: false,
    isPlanned: true,
  ),
  Sight(
    id: '0004',
    name: 'Test',
    lat: 37.4515504,
    lon: -122.054032,
    url:
    'https://windows10spotlight.com/wp-content/uploads/2019/12/a2c93088f3755e1fdd94a974cc4a06a5-768x432.jpg',
    details: 'Test location.',
    images: [],
    type: SightType.park,
    isVisited: false,
    isPlanned: true,
  ),
];
