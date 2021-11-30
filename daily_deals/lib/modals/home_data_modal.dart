import 'package:daily_deals/modals/product_modal.dart';
import 'package:daily_deals/modals/slider_modal.dart';
import 'package:daily_deals/modals/winner_modal.dart';

class HomeDataModal {
  final List<SliderModal>? slider;
  final List<ProductModal>? closingSoon;
  final List<ProductModal>? currentDeals;
  final List<ProductModal>? guessAndWin;
  final List<WinnerModal>? winners;

  HomeDataModal({
    this.slider,
    this.closingSoon,
    this.currentDeals,
    this.guessAndWin,
    this.winners,
  });

  factory HomeDataModal.fromJson(Map<String, dynamic> json) =>
      _$HomDataModalFromJson(json);
}

HomeDataModal _$HomDataModalFromJson(Map<String, dynamic> json) {
  return HomeDataModal(
    slider:
        (json['slider'] as List).map((e) => SliderModal.fromJson(e)).toList(),
    closingSoon: (json['closing_soon'] as List)
        .map((e) => ProductModal.fromJson(e))
        .toList(),
    currentDeals: (json['current_deals'] as List)
        .map((e) => ProductModal.fromJson(e))
        .toList(),
    guessAndWin: (json['guess_win'] as List)
        .map((e) => ProductModal.fromJson(e))
        .toList(),
    winners: (json['winners'] as List)
        .map((e) => WinnerModal.fromJson(e))
        .toList(),
  );
}
