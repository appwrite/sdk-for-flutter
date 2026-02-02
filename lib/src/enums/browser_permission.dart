part of '../../enums.dart';

enum BrowserPermission {
    geolocation(value: 'geolocation'),
    camera(value: 'camera'),
    microphone(value: 'microphone'),
    notifications(value: 'notifications'),
    midi(value: 'midi'),
    push(value: 'push'),
    clipboardRead(value: 'clipboard-read'),
    clipboardWrite(value: 'clipboard-write'),
    paymentHandler(value: 'payment-handler'),
    usb(value: 'usb'),
    bluetooth(value: 'bluetooth'),
    accelerometer(value: 'accelerometer'),
    gyroscope(value: 'gyroscope'),
    magnetometer(value: 'magnetometer'),
    ambientLightSensor(value: 'ambient-light-sensor'),
    backgroundSync(value: 'background-sync'),
    persistentStorage(value: 'persistent-storage'),
    screenWakeLock(value: 'screen-wake-lock'),
    webShare(value: 'web-share'),
    xrSpatialTracking(value: 'xr-spatial-tracking');

    const BrowserPermission({
        required this.value
    });

    final String value;

    String toJson() => value;
}