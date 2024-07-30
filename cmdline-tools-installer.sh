sdk="\$HOME/.android-sdk"

bin="$sdk/cmdline-tools/latest/bin"
site="https://developer.android.com/studio"
repo="https://dl.google.com/android/repository"

pattern="commandlinetools-linux-\d+_latest.zip"
name="$(curl -s $site | grep -Pom 1 $pattern)"

deps_not_installed=0

for cmd in java kotlin gradle
do
  if command -v $cmd > /dev/null; then
    echo "WARN: $cmd not installed!"
    deps_not_installed=1
  fi
done

if [ deps_not_installed -eq 1 ]; then
  echo -e '\n\nRecommend install from sdkman'
  echo 'Site: https://sdkman.io'
  echo 'Installation: curl -s "https://get.sdkman.io" | bash'
  echo 'Only run: sdk install gradle kotlin java 17.0.11-tem'
  echo 'Enjoy!'
fi

# Install command-line-tools
wget -q --show-progress "$repo/$name" 
unzip $name

mkdir latest sdk
mv cmdline-tools/* latest/
mv cmdline-tools/ sdk/
mv latest sdk/cmdline-tools/

echo 'Write in ~/.bash_profile or ~/.bashrc'
echo "export ANDROID_HOME=\"$sdk\""

echo 'OPTIONAL: Add Android Commands'
echo "export PATH=\"\$PATH:$bin\""

# Accept all licenses
yes | ./~/.android-sdk/cmdline-tools/latest/bin/sdkmanager --licenses
