import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:learn_bloc/features/cart/ui/cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initState
    cartBloc.add(CartInitalEvent());
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: Container());
    return Scaffold(
      appBar: AppBar(title: Text("Cart Items")),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is !CartActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                        cartBloc: cartBloc,
                        productDataModel: successState.cartItems[index]);
                  });
            default:
              return Container(child: Text("TEST"));
          }
        },
      ),
    );
  }
}
