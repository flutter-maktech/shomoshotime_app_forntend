# =========================
# Flutter
# =========================
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

# =========================
# Firebase
# =========================
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Firebase Analytics
-keep class com.google.android.gms.measurement.** { *; }
-dontwarn com.google.android.gms.measurement.**

# Firebase Auth
-keep class com.google.android.gms.auth.** { *; }
-dontwarn com.google.android.gms.auth.**

# =========================
# Google Identity / One Tap
# =========================
-keep class com.google.android.gms.auth.api.identity.** { *; }
-dontwarn com.google.android.gms.auth.api.identity.**

# Google Play Services
-keep class com.google.android.gms.common.** { *; }
-dontwarn com.google.android.gms.common.**
-keep class com.google.android.gms.tasks.** { *; }
-dontwarn com.google.android.gms.tasks.**

# Google Wallet / Pay
-keep class com.google.android.gms.wallet.** { *; }
-dontwarn com.google.android.gms.wallet.**

# =========================
# Stripe SDK
# =========================
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**

# Stripe Push Provisioning
-keep class com.stripe.android.pushProvisioning.** { *; }
-dontwarn com.stripe.android.pushProvisioning.**

# =========================
# SLF4J (Stripe dependency)
# =========================
-dontwarn org.slf4j.**

# =========================
# Gson (used by Firebase)
# =========================
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# =========================
# OkHttp (used by Firebase/Stripe)
# =========================
-dontwarn okhttp3.**
-dontwarn okio.**

# =========================
# Multidex support
# =========================
-keep class androidx.multidex.** { *; }
-dontwarn androidx.multidex.**

# =========================
# Parcelables (Fix ClassNotFoundException issues)
# =========================
-keepclassmembers class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}
