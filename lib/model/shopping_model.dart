import 'package:hive/hive.dart';

part 'shopping_model.g.dart';

@HiveType(typeId: 0)
class ShopModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  ShopModel({
    required this.id,
    required this.title,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
