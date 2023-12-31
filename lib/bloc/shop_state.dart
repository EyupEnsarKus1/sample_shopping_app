import '../model/shopping_model.dart';

abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<ShopModel> items;
  ShopLoaded(this.items);
}

class ShopError extends ShopState {
  final String message;
  ShopError(this.message);
}
