import 'package:mb_hero_post/domain/repositories/local_repository.dart';

class GetTotalProductUseCase {
  final LocalRepository localRepository;

  GetTotalProductUseCase({required this.localRepository});

  Future<int> getTotalProduct() {
    return localRepository.getTotalProduct();
  }
}

class GetTotalRevenueCase {
  final LocalRepository localRepository;

  GetTotalRevenueCase({required this.localRepository});

  Future<int> getTotalRevenue() {
    return localRepository.getTotalRevenue();
  }
}

class GetTotalRevenueTodayUseCase {
  final LocalRepository localRepository;

  GetTotalRevenueTodayUseCase({required this.localRepository});

  Future<double> getTotalRevenueToday() {
    return localRepository.getTotalRevenueToday();
  }
}

class GetTotalTransactionTodayUserCase {
  final LocalRepository localRepository;

  GetTotalTransactionTodayUserCase({required this.localRepository});

  Future<int> getTotalTransactionToday() {
    return localRepository.getTotalTransactionToday();
  }
}

class GetTotalTransactionUseCase {
  final LocalRepository localRepository;

  GetTotalTransactionUseCase({required this.localRepository});

  Future<int> getTotalTransaction() {
    return localRepository.getTotalTransaction();
  }
}

class GetTotalSpendingUseCase {
  final LocalRepository localRepository;

  GetTotalSpendingUseCase({required this.localRepository});

  Future<int> getTotalSpending() {
    return localRepository.getTotalSpending();
  }
}

class GetTotalSpendingTodayUseCase {
  final LocalRepository localRepository;

  GetTotalSpendingTodayUseCase({required this.localRepository});

  Future<double> getTotalSpending() {
    return localRepository.getTotalSpendingToday();
  }
}
