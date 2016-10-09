public class FetchWeatherDetails{
    
    public static void getWeather(){
        WeatherDeterminedClass.WeatherSoap wthrObj = new WeatherDeterminedClass.WeatherSoap();
        //wthrObj.clientCertName_x ='TestSelfSigned123';
        /*for(Integer i = 0;i<150;i++){
            System.debug('Weather ---->'+wthrObj.GetCityWeatherByZIP('80124'));
        }*/
        String zicode = '80124';
        System.debug('Weather ---->'+wthrObj.GetCityWeatherByZIP(zicode));
    }
}