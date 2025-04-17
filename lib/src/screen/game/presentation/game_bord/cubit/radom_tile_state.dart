part of 'radom_tile_cubit.dart';

@immutable
sealed class TileRackState {}

final class TileRackInitial extends TileRackState {}

final class TileRackLoading extends TileRackState {}

final class TileRackLoaded extends TileRackState {
  final List<Tile> tileRack;

  TileRackLoaded(this.tileRack);
}

final class TileRackError extends TileRackState {
  final String error;

  TileRackError(this.error);
}

final class TileRackItemRemove extends TileRackState {
  final Tile tile;

  TileRackItemRemove(this.tile);
}
