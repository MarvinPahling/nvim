# A very awesome NeoVim config

## How to make Java work?

This config uses [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) for Java/Kotlin development. In order to make this work you need an instance of [jdtls](https://github.com/eclipse-jdtls/eclipse.jdt.ls), a Java SDK and you have to export the following environment variables

To build `jdtls` from source run clone the official [repo](https://github.com/eclipse-jdtls/eclipse.jdt.ls) and run

```bash
JAVA_HOME=/path/to/java/21 ./mvnw clean verify -U -DskipTests=true
```

_or_ add the following to your shell config

```bash
# Add to your .zshrc or .bashrc
export JAVA_HOME="/path/to/JDK21/Home"
export PATH="$JAVA_HOME/bin:$PATH"
```

and run

```bash
./mvnw clean verify -U -DskipTests=true
```

```bash
# Add to your .zshrc or .bashrc
export JAVA_PATH="path/to/java/installation"
export JDTLS_INSTALL_LOCATION="Path/to/jdtls/root/directory"
export JDTLS_LAUNCHER_JAR="${JDTLS_INSTALL_LOCATION}/plugins/org.eclipse.equinox.launcher_<CHANGE_TO_REAL_VERSION_NUMBER>.jar"
export JDTLS_CONFIG_DIR="${JDTLS_INSTALL_LOCATION}/config_<CONFIG_FOR_YOUR_OS>"
export JDTLS_WORKSPACE_ROOT="path/to/workspace/of/your/Java/Kotlin/projects"
export JDK21_HOME="path/to/your/JDK/installation"
```

I also recommend to have the path to [Gradle](https://github.com/gradle/gradle) and [Maven](https://github.com/apache/maven) exported in your shell config

```bash
# Add to your .zshrc or .bashrc
export GRADLE_HOME="/path/to/gradle/8.14.2/libexec"
export PATH="$GRADLE_HOME/bin:$PATH"
export MAVEN_HOME="/path/to/maven/3.9.10/libexec"
export PATH="$MAVEN_HOME/bin:$PATH"
```

If you want to do Android development you pretty likely also want to export the path to your [Android SDK](https://developer.android.com/tools/releases/platform-tools)

```bash
# Add to your .zshrc or .bashrc
export ANDROID_HOME="path/to/Android/sdk"
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"
```
