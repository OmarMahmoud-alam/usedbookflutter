import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:usedbookshop/shared/variable.dart';

bool enableConsentButton = false;
bool _requireConsent = false;
String? debugLabelString;
const oneSignalAppId = "0b253c3d-52f6-4a06-ac9a-3494a340cb37";
// Platform messages are asynchronous, so we initialize in an async method.
Future<void> initPlatformState() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.Debug.setAlertLevel(OSLogLevel.none);
  OneSignal.consentRequired(_requireConsent);

  // NOTE: Replace with your own app ID from https://www.onesignal.com
  OneSignal.initialize(oneSignalAppId);
  OneSignal.Notifications.requestPermission(true);

  // AndroidOnly stat only
  // OneSignal.Notifications.removeNotification(1);
  // OneSignal.Notifications.removeGroupedNotifications("group5");

  OneSignal.Notifications.clearAll();

  OneSignal.User.pushSubscription.addObserver((state) {
    print(OneSignal.User.pushSubscription.optedIn);
    print(OneSignal.User.pushSubscription.id);
    print(OneSignal.User.pushSubscription.token);
    print(state.current.jsonRepresentation());
  });
  sendUserTag(currentuser!.id);

  OneSignal.Notifications.addPermissionObserver((state) {
    print("Has permission " + state.toString());
  });

  OneSignal.Notifications.addClickListener((event) {
    print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
  });

  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    print(
        'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

    /// Display Notification, preventDefault to not display
    event.preventDefault();

    /// Do async work

    /// notification.display() to display after preventing default
    event.notification.display();

    var debugLabelString =
        "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
  });

  OneSignal.InAppMessages.addClickListener((event) {
    debugLabelString =
        "In App Message Clicked: \n${event.result.jsonRepresentation().replaceAll("\\n", "\n")}";
  });
  OneSignal.InAppMessages.addWillDisplayListener((event) {
    print("ON WILL DISPLAY IN APP MESSAGE ${event.message.messageId}");
  });
  OneSignal.InAppMessages.addDidDisplayListener((event) {
    print("ON DID DISPLAY IN APP MESSAGE ${event.message.messageId}");
  });
  OneSignal.InAppMessages.addWillDismissListener((event) {
    print("ON WILL DISMISS IN APP MESSAGE ${event.message.messageId}");
  });
  OneSignal.InAppMessages.addDidDismissListener((event) {
    print("ON DID DISMISS IN APP MESSAGE ${event.message.messageId}");
  });

//    _enableConsentButton = _requireConsent;

  // Some examples of how to use In App Messaging public methods with OneSignal SDK
  oneSignalInAppMessagingTriggerExamples();

  // Some examples of how to use Outcome Events public methods with OneSignal SDK
  oneSignalOutcomeExamples();

  OneSignal.InAppMessages.paused(true);
}

const tagName = "userId";

void sendUserTag(int userId) {
  OneSignal.User.addTags({tagName: userId}).then((response) {
    print("Successfully sent tags with response");
  }).catchError((error) {
    print("Encountered an error sending tags: $error");
  });
}

void _handleSendTags() {
  print("Sending tags");
  OneSignal.User.addTagWithKey("test2", "val2");

  print("Sending tags array");
  var sendTags = {'test': 'value', 'test2': 'value2'};
  OneSignal.User.addTags(sendTags);
}

void _handleRemoveTag() {
  print("Deleting tag");
  OneSignal.User.removeTag("test2");

  print("Deleting tags array");
  OneSignal.User.removeTags(['test']);
}

void _handlePromptForPushPermission() {
  print("Prompting for Permission");
  OneSignal.Notifications.requestPermission(true);
}

void _handleConsent() {
  print("Setting consent to true");
  OneSignal.consentGiven(true);

  print("Setting state");

  enableConsentButton = false;
}

void _handleSetLocationShared() {
  print("Setting location shared to true");
  OneSignal.Location.setShared(true);
}

void _handleLogin() {
  print("Setting external user ID");
  if (currentuser?.id == null) return;
  OneSignal.login(currentuser!.id.toString());
  OneSignal.User.addAlias("fb_id", "1341524");
}

void _handleLogout() {
  OneSignal.logout();
  OneSignal.User.removeAlias("fb_id");
}

oneSignalInAppMessagingTriggerExamples() async {
  /// Example addTrigger call for IAM
  /// This will add 1 trigger so if there are any IAM satisfying it, it
  /// will be shown to the user
  OneSignal.InAppMessages.addTrigger("trigger_1", "one");

  /// Example addTriggers call for IAM
  /// This will add 2 triggers so if there are any IAM satisfying these, they
  /// will be shown to the user
  Map<String, String> triggers = new Map<String, String>();
  triggers["trigger_2"] = "two";
  triggers["trigger_3"] = "three";
  OneSignal.InAppMessages.addTriggers(triggers);

  // Removes a trigger by its key so if any future IAM are pulled with
  // these triggers they will not be shown until the trigger is added back
  OneSignal.InAppMessages.removeTrigger("trigger_2");

  // Create a list and bulk remove triggers based on keys supplied
  List<String> keys = ["trigger_1", "trigger_3"];
  OneSignal.InAppMessages.removeTriggers(keys);

  // Toggle pausing (displaying or not) of IAMs
  OneSignal.InAppMessages.paused(true);
  var arePaused = await OneSignal.InAppMessages.arePaused();
  print('Notifications paused ${arePaused}');
}

oneSignalOutcomeExamples() async {
  OneSignal.Session.addOutcome("normal_1");
  OneSignal.Session.addOutcome("normal_2");

  OneSignal.Session.addUniqueOutcome("unique_1");
  OneSignal.Session.addUniqueOutcome("unique_2");

  OneSignal.Session.addOutcomeWithValue("value_1", 3.2);
  OneSignal.Session.addOutcomeWithValue("value_2", 3.9);
}

void _handleOptIn() {
  OneSignal.User.pushSubscription.optIn();
}

void _handleOptOut() {
  OneSignal.User.pushSubscription.optOut();
}
