plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.mahmoud.quran"
    compileSdk = 36
    buildToolsVersion = "36.1.0"
    ndkVersion = "29.0.14206865"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.mahmoud.quran"
        minSdk = flutter.minSdkVersion
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"
        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            storeFile = file("quran-release.jks")
            storePassword = "mahmoud01211410889Md@"
            keyAlias = "quran_key"
            keyPassword = "mahmoud01211410889Md@"
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
             getByName("release") {
            ndk {
                debugSymbolLevel = "SYMBOL_TABLE"
            }
        }
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.window:window:1.0.0")
    implementation("androidx.window:window-java:1.0.0")
}

flutter {
    source = "../.."
}
