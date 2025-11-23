# Keep all your model classes (JSON parsing)
-keep class com.mahmoud.quran.models.** { *; }

# Keep Gson classes
-keep class com.google.gson.** { *; }

# Keep Retrofit classes
-keep class retrofit2.** { *; }
-keep class okhttp3.** { *; }

# Keep classes annotated with @Keep
-keep @androidx.annotation.Keep class * { *; }

# Keep AudioService plugin classes
-keep class com.ryanheise.audioservice.** { *; }

# Keep Flutter local notifications classes
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Keep any generated JSON adapters
-keep class kotlinx.serialization.** { *; }
