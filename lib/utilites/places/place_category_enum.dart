enum PlaceCategory{
  TREKKING,
  CYCLING,
  SWIMMING,
  RUNNING,
  CAMPING,
  WILDLIFE
}

extension ParseToString on PlaceCategory{
  String toShortString() {
    return toString().split('.').last;
  }
}