

abstract class LayoutStates{}


 class LayoutInitialStates extends LayoutStates{}




 class GetUserDataSuccessStates extends LayoutStates{}
 class GetUserDataLoadingStates extends LayoutStates{}
 class GetUserFailedStates extends LayoutStates{
 String error;

 GetUserFailedStates({required this.error});

 }



 class GetBannersSuccessState extends LayoutStates{}
 class GetBannerLoadingStates extends LayoutStates{}
 class FailedToGetBannersState extends LayoutStates{}




 class GetcatgorysSuccessState extends LayoutStates{}
 class GetcatgorysLoadingStates extends LayoutStates{}
 class FailedToGetcatgorysState extends LayoutStates{}

 class FilterProductState extends LayoutStates{}




class GetFavoritesSuccessState extends LayoutStates{}
class GetFavoritesLoadingStates extends LayoutStates{}
class FailedToGetFavoritesState extends LayoutStates{}



class AddOrRemoveItemFromFavoritesSuccessState extends LayoutStates{}
class FailedToAddOrRemoveItemFromFavoritesState extends LayoutStates{


}
class GetCartsSuccessState extends LayoutStates{}
class FailedToGetCartsState extends LayoutStates{}

class AddToCartsSuccessState extends LayoutStates{}
class FailedAddToCartsState extends LayoutStates{}
