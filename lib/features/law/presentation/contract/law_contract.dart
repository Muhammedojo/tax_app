import '../../../../core/utils/contract.dart';

abstract class LawControllerContract {
  String get selectedFilter;
  void selectFilter(String filter);
}

abstract class LawViewContract extends BaseViewContract {}
