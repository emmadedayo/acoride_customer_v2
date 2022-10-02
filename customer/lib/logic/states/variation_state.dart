import 'package:acoride/data/model/variation_model.dart';

class VariationState{
  bool isLoading;
  String message;
  bool? hasError;
  List<VariationModel> variationModel;
  List<VariationModel> variationSearch;
  VariationModel? selectedVariation;
  String name;

  VariationState({required this.message,this.hasError,this.isLoading = false,this.variationModel = const [],this.variationSearch = const [],this.selectedVariation,this.name = ''});

  VariationState copy() {
    VariationState copy = VariationState(
      isLoading: isLoading,
      name: name,
      variationSearch: variationSearch,
      hasError: hasError,
      message: message,
      variationModel: variationModel,
      selectedVariation: selectedVariation,
    );
    return copy;
  }
}