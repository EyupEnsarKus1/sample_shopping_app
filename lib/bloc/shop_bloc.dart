import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_shopping_app/bloc/shop_event.dart';
import 'package:sample_shopping_app/bloc/shop_state.dart';

import '../model/shopping_model.dart';
import '../service/hive_service.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final HiveService<ShopModel> hiveService;

  ShopBloc(this.hiveService) : super(ShopInitial()) {
    on<LoadItems>(_onLoadItems);
    on<AddItem>(_addShopItem);
    on<UpdateItem>(_updateShopItem);
    on<DeleteItem>(_deleteShopItem);
  }

  Future<void> _onLoadItems(LoadItems event, Emitter<ShopState> emit) async {
    emit(ShopLoading());
    try {
      final items = await hiveService.getAllItems();
      emit(ShopLoaded(items));
    } catch (e) {
      emit(ShopError('Öğeler yüklenirken bir hata oluştu'));
    }
  }

  Future<void> _addShopItem(AddItem event, Emitter<ShopState> emit) async {
    emit(ShopLoading());
    try {
      await hiveService.addItemWithCustomKey(event.item.id, event.item);
      final items = hiveService.getBox().values.toList();
      emit(ShopLoaded(items));
    } catch (e) {
      emit(ShopError(e.toString()));
    }
  }

  Future<void> _updateShopItem(UpdateItem event, Emitter<ShopState> emit) async {
    emit(ShopLoading());
    try {
      await hiveService.updateItem(event.updatedItem.id, event.updatedItem);
      final items = hiveService.getBox().values.toList();
      emit(ShopLoaded(items));
    } catch (e) {
      emit(ShopError(e.toString()));
    }
  }

  Future<void> _deleteShopItem(DeleteItem event, Emitter<ShopState> emit) async {
    emit(ShopLoading());
    try {
      await hiveService.removeItem(event.item.id);
      final items = hiveService.getBox().values.toList();
      emit(ShopLoaded(items));
    } catch (e) {
      emit(ShopError(e.toString()));
    }
  }
}
