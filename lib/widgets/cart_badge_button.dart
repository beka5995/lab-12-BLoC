import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_state.dart';

class CartBadgeButton extends StatelessWidget {
  final VoidCallback onTap;

  const CartBadgeButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        // totalQuantity считает общее количество всех штук (2 айфона + 1 макбук = 3)
        return IconButton(
          icon: Badge(
            label: Text('${state.totalQuantity}'),
            isLabelVisible: state.totalQuantity > 0,
            child: const Icon(Icons.shopping_cart, size: 26),
          ),
          onPressed: onTap,
        );
      },
    );
  }
}
