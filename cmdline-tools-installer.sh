# Dependencies
sudo apt install openjdk-11-jdk

dir="sdk/cmdline-tools/latest"
site="https://developer.android.com/studio"
repo="https://dl.google.com/android/repository"

pattern="commandlinetools-linux-\d+_latest.zip"
name="$(curl -s $site | grep -Pom 1 $pattern)"

# Install command-line-tools
wget -q --show-progress "$repo/$name" 
unzip $name

mkdir latest sdk
mv cmdline-tools/* latest/
mv cmdline-tools/ sdk/
mv latest sdk/cmdline-tools/

echo "
export ANDROID_SDK_ROOT='$(realpath ./sdk)'
" >> ~/.bashrc

# Accept all licenses
./$dir/bin/sdkmanager --licenses

source ~/.bashrc

