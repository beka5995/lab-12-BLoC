import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    // 1. ДОБАВИТЬ ТОВАР (или увеличить счетчик +1)
    on<AddProductEvent>((event, emit) {
      final existingIndex = state.items.indexWhere(
        (item) => item.product.id == event.product.id,
      );

      List<CartItem> updatedItems = List.from(state.items);

      if (existingIndex >= 0) {
        // Товар уже в корзине: увеличиваем количество на +1
        final current = updatedItems[existingIndex];
        updatedItems[existingIndex] = current.copyWith(quantity: current.quantity + 1);
      } else {
        // Новый товар: добавляем в корзину с quantity = 1
        updatedItems.add(CartItem(product: event.product, quantity: 1));
      }

      emit(CartState(items: updatedItems));
    });

    // 2. УМЕНЬШИТЬ КОЛИЧЕСТВО НА -1 (если 0 — удаляем)
    on<DecrementProductEvent>((event, emit) {
      final existingIndex = state.items.indexWhere(
        (item) => item.product.id == event.productId,
      );

      if (existingIndex >= 0) {
        List<CartItem> updatedItems = List.from(state.items);
        final current = updatedItems[existingIndex];

        if (current.quantity > 1) {
          // Уменьшаем количество на 1
          updatedItems[existingIndex] = current.copyWith(quantity: current.quantity - 1);
        } else {
          // Если оставалась 1 штука — удаляем позицию
          updatedItems.removeAt(existingIndex);
        }

        emit(CartState(items: updatedItems));
      }
    });

    // 3. ПОЛНОСТЬЮ УДАЛИТЬ ПОЗИЦИЮ (клик на мусорку)
    on<RemoveProductEvent>((event, emit) {
      final updatedItems = state.items.where(
        (item) => item.product.id != event.productId,
      ).toList();

      emit(CartState(items: updatedItems));
    });

    // 4. ОЧИСТИТЬ ВСЮ КОРЗИНУ
    on<ClearCartEvent>((event, emit) {
      emit(const CartState(items: []));
    });
  }
}
