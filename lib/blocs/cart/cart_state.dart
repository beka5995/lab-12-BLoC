import 'package:equatable/equatable.dart';
import '../../models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  // Общее количество штук всех товаров (для бейджа в AppBar: 2 айфона + 1 макбук = 3 шт)
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  // Общая сумма всех покупок
  double get totalPrice => items.fold(0.0, (sum, item) => sum + item.subtotal);

  // Найти количество конкретного товара в корзине
  int getProductQuantity(String productId) {
    final found = items.where((i) => i.product.id == productId).toList();
    return found.isNotEmpty ? found.first.quantity : 0;
  }

  @override
  List<Object?> get props => [items];
}
