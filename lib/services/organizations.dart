part of '../appwrite.dart';

class Organizations extends Service {
  /// Initializes a [Organizations] service
  Organizations(super.client);

  /// Delete an organization.
  Future delete({required String organizationId}) async {
    final String apiPath = '/organizations/{organizationId}'
        .replaceAll('{organizationId}', organizationId);

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.delete,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return res.data;
  }

  /// Get a billing address using it's ID.
  Future<models.BillingAddress> getBillingAddress(
      {required String organizationId,
      required String billingAddressId}) async {
    final String apiPath =
        '/organizations/{organizationId}/billing-addresses/{billingAddressId}'
            .replaceAll('{organizationId}', organizationId)
            .replaceAll('{billingAddressId}', billingAddressId);

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {};

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.BillingAddress.fromMap(res.data);
  }

  /// Get estimation for deleting an organization.
  Future<models.EstimationDeleteOrganization> estimationDeleteOrganization(
      {required String organizationId}) async {
    final String apiPath =
        '/organizations/{organizationId}/estimations/delete-organization'
            .replaceAll('{organizationId}', organizationId);

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.patch,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.EstimationDeleteOrganization.fromMap(res.data);
  }

  /// Submit feedback about downgrading from a paid plan to a lower tier. This
  /// helps the team understand user experience and improve the platform.
  ///
  Future<models.DowngradeFeedback> createDowngradeFeedback(
      {required String organizationId,
      required String reason,
      required String message,
      required String fromPlanId,
      required String toPlanId}) async {
    final String apiPath = '/organizations/{organizationId}/feedbacks/downgrade'
        .replaceAll('{organizationId}', organizationId);

    final Map<String, dynamic> apiParams = {
      'reason': reason,
      'message': message,
      'fromPlanId': fromPlanId,
      'toPlanId': toPlanId,
    };

    final Map<String, String> apiHeaders = {
      'content-type': 'application/json',
    };

    final res = await client.call(HttpMethod.post,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.DowngradeFeedback.fromMap(res.data);
  }

  /// Get an organization's payment method using it's payment method ID.
  Future<models.PaymentMethod> getPaymentMethod(
      {required String organizationId, required String paymentMethodId}) async {
    final String apiPath =
        '/organizations/{organizationId}/payment-methods/{paymentMethodId}'
            .replaceAll('{organizationId}', organizationId)
            .replaceAll('{paymentMethodId}', paymentMethodId);

    final Map<String, dynamic> apiParams = {};

    final Map<String, String> apiHeaders = {};

    final res = await client.call(HttpMethod.get,
        path: apiPath, params: apiParams, headers: apiHeaders);

    return models.PaymentMethod.fromMap(res.data);
  }
}
