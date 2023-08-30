part of appwrite.models;

/// ProviderRepository
class ProviderRepository implements Model {
    /// VCS (Version Control System) repository ID.
    final String id;
    /// VCS (Version Control System) repository name.
    final String name;
    /// VCS (Version Control System) organization name
    final String organization;
    /// VCS (Version Control System) provider name.
    final String provider;
    /// Is VCS (Version Control System) repository private?
    final bool private;
    /// Auto-detected runtime suggestion. Empty if getting response of getRuntime().
    final String runtime;
    /// Last commit date in ISO 8601 format.
    final String pushedAt;

    ProviderRepository({
        required this.id,
        required this.name,
        required this.organization,
        required this.provider,
        required this.private,
        required this.runtime,
        required this.pushedAt,
    });

    factory ProviderRepository.fromMap(Map<String, dynamic> map) {
        return ProviderRepository(
            id: map['id'].toString(),
            name: map['name'].toString(),
            organization: map['organization'].toString(),
            provider: map['provider'].toString(),
            private: map['private'],
            runtime: map['runtime'].toString(),
            pushedAt: map['pushedAt'].toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "id": id,
            "name": name,
            "organization": organization,
            "provider": provider,
            "private": private,
            "runtime": runtime,
            "pushedAt": pushedAt,
        };
    }
}
