import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/shop_bloc.dart';
import 'bloc/shop_event.dart';
import 'bloc/shop_state.dart';
import 'model/shopping_model.dart';

class ShopListPage extends StatelessWidget {
  const ShopListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ShopLoaded) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return ListTile(
                  title: Text(item.title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showEditDialog(context, item),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => context.read<ShopBloc>().add(DeleteItem(item)),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ShopError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container(); // Empty container for initial or unknown states
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Add Item'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Item title'),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                final newItem = ShopModel(id: DateTime.now().toString(), title: titleController.text);
                context.read<ShopBloc>().add(AddItem(newItem));
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, ShopModel item) {
    TextEditingController titleController = TextEditingController(text: item.title);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Item title'),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              child: Text('Update'),
              onPressed: () {
                final updatedItem = ShopModel(id: item.id, title: titleController.text);
                context.read<ShopBloc>().add(UpdateItem(updatedItem));
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
