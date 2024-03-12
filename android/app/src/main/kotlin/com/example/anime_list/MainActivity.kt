package com.example.anime_list

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.net.URL


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.anime/methodChannel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->


            if (call.method == "fetchAnimeList") {
                GlobalScope.launch(Dispatchers.IO) {
                    val animeList = fetchAnimeListFromApi(call.arguments as String)
                    withContext(Dispatchers.Main) {
                        result.success(animeList)
                    }
                }
            }
            else if (call.method == "fetchAnimeDetail"){
                GlobalScope.launch(Dispatchers.IO) {
                    val animeList = fetchAnimeListFromApi(call.arguments as String)
                    withContext(Dispatchers.Main) {
                        result.success(animeList)
                    }
                }
            }
            else {
                result.notImplemented()
            }
        }
    }

    private fun fetchAnimeListFromApi(url:String): String {
        val apiUrl = url
       // val apiUrl = "https://api.jikan.moe/v4/top/anime"
        val response = URL(apiUrl).readText()
        return  response

    }

}
