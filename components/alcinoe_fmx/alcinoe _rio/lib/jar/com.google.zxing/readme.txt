download the jar from 
https://mvnrepository.com/artifact/com.google.zxing/core

*************************

I rename the jar for for exemple core.jar to zxing-core.jar
because it's very stupid to have a library named core.jar 

*************************

to know all the dependancies needed by a libraries, create a android
studio project, add the dependancies: 

dependencies { 
  implementation 'com.google.zxing:core:3.3.2'
}

and then run: gradlew app:dependencies

\--- com.google.zxing:core:3.3.2