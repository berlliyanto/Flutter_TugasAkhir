// ignore: file_names, depend_on_referenced_packages
import 'package:collection/collection.dart';

// CHART PRODUCTION
class productionPoint{
  late final double x;
  late final double y;
  productionPoint({required this.x, required this.y});
}

List<productionPoint> get proPoint{
  final data = <double>[2, 4, 6, 9, 12, 7, 5];
  return data.mapIndexed((index, element) => productionPoint(x: index.toDouble(), y: element)).toList();
}