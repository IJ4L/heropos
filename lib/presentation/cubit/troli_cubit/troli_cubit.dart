import 'package:bloc/bloc.dart';
import 'package:mb_hero_post/data/models/product_model.dart';

class TroliCubit extends Cubit<TroliState> {
  TroliCubit() : super(TroliState([], 0.0));

  void addToTroli(ProductModel product, double price) {
    final existingProductIndex = state.products.indexWhere(
      (existingProduct) => existingProduct == product,
    );

    if (existingProductIndex == -1) {
      final newTotalPrice = state.totalPrice + price;
      emit(TroliState([...state.products, product], newTotalPrice));
    } else {
      List<ProductModel> newProducts = List.from(state.products);
      newProducts[existingProductIndex].quantity += 1;

      emit(
        TroliState(
          newProducts,
          state.totalPrice + price,
        ),
      );
    }
  }

  void removeFromTroli(ProductModel product, double price) {
    final existingProductIndex = state.products.indexWhere(
      (existingProduct) => existingProduct == product,
    );

    if (existingProductIndex != -1) {
      double totalPrice = state.totalPrice - price;
      totalPrice = totalPrice >= 0.0 ? totalPrice : 0.0;

      List<ProductModel> newProducts = List.from(state.products);
      newProducts[existingProductIndex].quantity -= 1;

      if (newProducts[existingProductIndex].quantity <= 0) {
        newProducts.removeAt(existingProductIndex);
      }

      emit(
        TroliState(
          newProducts,
          totalPrice,
        ),
      );
    }
  }

  void decreaseQuantity(ProductModel product) {
    final existingProductIndex = state.products.indexWhere(
      (existingProduct) => existingProduct == product,
    );

    if (existingProductIndex != -1) {
      List<ProductModel> newProducts = List.from(state.products);
      newProducts[existingProductIndex].quantity -= 1;

      newProducts[existingProductIndex].quantity =
          newProducts[existingProductIndex]
              .quantity
              .clamp(0, double.infinity)
              .toInt();

      double totalPrice = 0.0;
      for (var product in newProducts) {
        totalPrice += double.parse(product.priceOfProduct) * product.quantity;
      }

      emit(
        TroliState(
          newProducts,
          totalPrice,
        ),
      );
    }
  }

  void reset() {
    emit(TroliState([], 0.0));
  }
}

class TroliState {
  final List<ProductModel> products;
  final double totalPrice;

  TroliState(this.products, this.totalPrice);
}
