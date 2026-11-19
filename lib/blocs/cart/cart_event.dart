import 'package:equatable/equatable.dart';
import '../../models/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

// 1. Добавить товар (если уже есть — увеличиваем счетчик +1)
class AddProductEvent extends CartEvent {
  final Product product;
  const AddProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

// 2. Уменьшить количество на 1 (если стало 0 — удаляем из корзины)
class DecrementProductEvent extends CartEvent {
  final String productId;
  const DecrementProductEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

// 3. Полностью удалить позицию из корзины (мусорка)
class RemoveProductEvent extends CartEvent {
  final String productId;
  const RemoveProductEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

// 4. Очистить всю корзину
class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}
