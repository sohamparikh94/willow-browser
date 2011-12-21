rem Windows build script.
rem Currently only builds the standalone app jar as the signing function doesn't work for javafxpackager (http://javafx-jira.kenai.com/browse/RT-18246)

rem cleanup the output directories
rd /S /Q out
rd /S /Q dist
rd /S /Q dist-web
rd /S /Q dist-signed

rem create the compile output directory
mkdir out

rem compile the source
"%JDK_HOME%\bin\javac" src\main\java\org\jewelsea\willow\*.java -classpath "%JAVAFX_SDK_HOME%\rt\lib\jfxrt.jar;lib\*" -d out

rem copy the resources to the output
xcopy /S src\main\resources\* out\*

rem package the app as a click to run jar
"%JAVAFX_SDK_HOME%\bin\javafxpackager" -createjar -appclass org.jewelsea.willow.Willow -srcdir out -classpath lib\image4j.jar;lib\PDFRenderer-0.9.1.jar -outdir dist -runtimeversion 2.0 -outfile willow.jar -v

rem copy the lib files to the distribution
mkdir dist\lib
xcopy /S lib dist\lib

rem package the app as a webstart app and applet
rem "%JAVAFX_SDK_HOME%\bin\javafxpackager" -deploy -outdir dist-web -outfile Willow -width 1121 -height 600 -name Willow -appclass org.jewelsea.willow.Willow.class -v -srcdir dist -srcfiles Willow.jar;lib\image4j.jar;lib\PDFRenderer-0.9.1.jar -v

rem sign the app
rem "%JAVAFX_SDK_HOME%\bin\javafxpackager" -signjar -outdir dist-signed -keyStore willow.jks -storePass willow -alias willow -keypass willow -srcdir dist


