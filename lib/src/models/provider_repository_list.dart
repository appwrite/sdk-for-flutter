part of appwrite.models;

/// Provider Repositories List
class ProviderRepositoryList implements Model {
    /// Total number of providerRepositories documents that matched your query.
    final int total;
    /// List of providerRepositories.
    final List<ProviderRepository> providerRepositories;

    ProviderRepositoryList({
        required this.total,
        required this.providerRepositories,
    });

    factory ProviderRepositoryList.fromMap(Map<String, dynamic> map) {
        return ProviderRepositoryList(
            total: map['total'],
            providerRepositories: List<ProviderRepository>.from(map['providerRepositories'].map((p) => ProviderRepository.fromMap(p))),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "total": total,
            "providerRepositories": providerRepositories.map((p) => p.toMap()).toList(),
        };
    }
}
