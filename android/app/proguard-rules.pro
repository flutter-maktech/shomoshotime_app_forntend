# =========================
# Stripe SDK
# =========================
-keep class com.stripe.** { *; }
-dontwarn com.stripe.**

# =========================
# Stripe Push Provisioning
# =========================
-keep class com.stripe.android.pushProvisioning.** { *; }
-dontwarn com.stripe.android.pushProvisioning.**

# =========================
# Google Wallet / Pay
# =========================
-keep class com.google.android.gms.wallet.** { *; }
-dontwarn com.google.android.gms.wallet.**

# =========================
# SLF4J (Stripe dependency)
# =========================
-dontwarn org.slf4j.**
