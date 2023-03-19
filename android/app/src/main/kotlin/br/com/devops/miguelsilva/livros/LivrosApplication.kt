package br.com.devops.miguelsilva.livros

import android.content.Context
import androidx.multidex.MultiDex

import io.flutter.app.FlutterApplication

class LivrosApplication : FlutterApplication() {
    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }
}
