setlocal
::Get the current batch file's short path
for %%x in (%0) do set BatchPath=%%~dpsx
for %%x in (%BatchPath%) do set BatchPath=%%~dpsx

if exist %BatchPath%\jdk-11 (
  echo "Using bundled JDK."
  set JAVA_HOME=%BatchPath%\jdk-11
  set JAVA_COM=%BatchPath%\jdk-11\bin\java
) else (
  echo "Bundled JDK not found.  Using system JDK."
  set JAVA_COM=java
)

start %JAVA_CMD% --module-path=%BatchPath%\lib -Xmx4g -Dproduction=true --class-path="%BatchPath%/lib_classpath/*" @%BatchPath%\igv.args -Djava.net.preferIPv4Stack=true -Dsun.java2d.noddraw=true --module=org.igv/org.broad.igv.ui.Main  %*
