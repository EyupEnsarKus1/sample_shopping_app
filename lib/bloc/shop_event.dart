import '../model/shopping_model.dart';

abstract class ShopEvent {}

class AddItem extends ShopEvent {
  final ShopModel item;
  AddItem(this.item);
}

class UpdateItem extends ShopEvent {
  final ShopModel updatedItem;
  UpdateItem(this.updatedItem);
}

class DeleteItem extends ShopEvent {
  final ShopModel item;
  DeleteItem(this.item);
}
