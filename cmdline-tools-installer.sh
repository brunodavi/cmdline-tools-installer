# Dependencies
apt install openjdk-11-jdk

dir="sdk/cmdline-tools/latest"
site="https://developer.android.com/studio"
repo="https://dl.google.com/android/repository"

pattern="commandlinetools-linux-\d+_latest.zip"
name="$(curl -s $site | grep -Pom 1 $pattern)"

# Install command-line-tools
mkdir -p $dir
wget -q --show-progress "$repo/$name" 
unzip -jo $name cmdline-tools -d $dir

echo "
export ANDROID_SDK_ROOT='$(realpath ./sdk)'
" >> ~/.bashrc

# Accept all licenses
./$dir/bin/sdkmanager --licenses

source ~/.bashrc

