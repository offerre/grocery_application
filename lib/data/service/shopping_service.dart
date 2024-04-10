import 'package:dio/dio.dart';
import 'package:grocery_application/data/remote/products/response/products_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'shopping_service.g.dart';

@singleton
@RestApi()
abstract class ShoppingService {
  @factoryMethod
  factory ShoppingService(Dio dio) => _ShoppingService(dio);

  @GET('/products')
  Future<ProductsResponse> fetchProductList(
    @Query('skip') int offSet,
    @Query('limit') int limit,
  );
}
