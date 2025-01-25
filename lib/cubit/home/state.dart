abstract class HomeState {}

class AppInitialState extends HomeState {}
class ChangedAdSliderState extends HomeState {}
class CategoriesGetLoadingState extends HomeState {}
class CategoriesGetErrorState extends HomeState {}
class CategoriesGetSuccessState extends HomeState {}
class NewArriveGetSuccessState extends HomeState {}

class ProductsGetLoadingState extends HomeState {}
class ProductsGetErrorState extends HomeState {}
class ProductsGetSuccessState extends HomeState {}

//SetInCardState
class JoinSharedCartLoadingState extends HomeState {}
class JoinSharedCartErrorState extends HomeState {}
class JoinSharedCartSuccessState extends HomeState {}

class SetInCardState extends HomeState {}

class AddToCartItemsGetLoadingState extends HomeState {}
class AddToCartItemsGetErrorState extends HomeState {}
class AddToCartItemsGetSuccessState extends HomeState {}




class CartEditLoadingState extends HomeState {}
class CartEditErrorState extends HomeState {}
class CartEditSuccessState extends HomeState {}

class SliderLoadingState extends HomeState {}
class SliderErrorState extends HomeState {}
class SliderSuccessState extends HomeState {}
