import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.shomoshotime.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

  compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.shomoshotime.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
        externalNativeBuild {
            cmake {
                arguments += listOf("-DANDROID_SUPPORT_FLEXIBLE_PAGE_SIZES=ON")
            }
         }
    }

    signingConfigs {

    getByName("debug") {
        storeFile = keystoreProperties["storeFile"]?.let { file(it) }
        storePassword = keystoreProperties["storePassword"] as String
        keyAlias = keystoreProperties["keyAlias"] as String
        keyPassword = keystoreProperties["keyPassword"] as String
    }
    create("release") {
        storeFile = keystoreProperties["storeFile"]?.let { file(it) }
        storePassword = keystoreProperties["storePassword"] as String
        keyAlias = keystoreProperties["keyAlias"] as String
        keyPassword = keystoreProperties["keyPassword"] as String
    }
}

    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        ndk {
           abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86_64"))
           debugSymbolLevel = "FULL"
           }
        }

        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        ndk {
           abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86_64"))
           debugSymbolLevel = "FULL"
           }
        }
    }
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:34.8.0"))

    // Firebase
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")

    // Google Sign-In (correct published artifact)
    implementation("com.google.android.gms:play-services-auth:21.5.0")

    // Core and tasks
    implementation("com.google.android.gms:play-services-base:18.9.0")
    implementation("com.google.android.gms:play-services-tasks:18.3.0")

    // Multidex support if you use multidex
    implementation("androidx.multidex:multidex:2.0.1")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}


flutter {
    source = "../.."
}
