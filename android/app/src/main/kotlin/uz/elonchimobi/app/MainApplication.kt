package uz.elonchimobi.app

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setLocale("Ru_ru") 
        MapKitFactory.setApiKey("249d9102-405b-4960-8563-0fc01c2e4518")
    }
}
