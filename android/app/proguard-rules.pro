# Flutter rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Google Play Core (deferred components)
-dontwarn com.google.android.play.core.**

# Firebase & Google Play Services
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-dontwarn com.google.android.gms.**
-dontwarn com.google.firebase.**
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
