/// enums for detecting if tile correct position should be at one of the boarder's corners
enum CornersEnum {
  topLeftCorner,
  topRightCorner,
  bottomLeftCorner,
  bottomRightCorner,
  none,
}

/// pass index of tile's value in [valuesCornerTiles]
/// 0 - the top left corner, 1 - the top right corner,
/// 2 - the bottom left corner, 3 - the bottom right corner.
/// In other cases, tile is not the corner one.
CornersEnum setCorner(int value) {
  switch (value) {
    case 0:
      return CornersEnum.topLeftCorner;
    case 1:
      return CornersEnum.topRightCorner;
    case 2:
      return CornersEnum.bottomLeftCorner;
    case 3:
      return CornersEnum.bottomRightCorner;
    default:
      return CornersEnum.none;
  }
}
