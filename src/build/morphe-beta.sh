#!/bin/bash
# Morphe build
source ./src/build/utils.sh
# Download requirements
morphe_dl(){
	dl_gh "morphe-patches" "MorpheApp" "prerelease"
	dl_gh "morphe-cli" "MorpheApp" "latest"
}
1() {
	morphe_dl
	# Patch YouTube:
	get_patches_key "youtube-morphe"
	prefer_version="21.08.261"
	get_apk "com.google.android.youtube" "youtube-beta" "youtube" "google-inc/youtube/youtube"
	patch "youtube-beta" "morphe" "morphe"
	# Remove unused architectures
	for i in {0..3}; do
	  apk_editor "youtube-beta" "${archs[i]}" ${libs[i]}
	done
	# Patch Youtube Arm64-v8a
	get_patches_key "youtube-morphe"
	patch "youtube-beta-arm64-v8a" "morphe" "morphe"
	# Patch Youtube Armeabi-v7a
	get_patches_key "youtube-morphe"
	patch "youtube-beta-armeabi-v7a" "morphe" "morphe"
}
2() {
	morphe_dl
	# Patch YouTube Music:
	# Arm64-v8a
	get_patches_key "youtube-music-morphe"
	get_apk "com.google.android.apps.youtube.music" "youtube-music-beta-arm64-v8a" "youtube-music" "google-inc/youtube-music/youtube-music" "arm64-v8a"
	patch "youtube-music-beta-arm64-v8a" "morphe" "morphe"
	# Armeabi-v7a
	get_patches_key "youtube-music-morphe"
	get_apk "com.google.android.apps.youtube.music" "youtube-music-beta-armeabi-v7a" "youtube-music" "google-inc/youtube-music/youtube-music" "armeabi-v7a"
	patch "youtube-music-beta-armeabi-v7a" "morphe" "morphe"
}
case "$1" in
    1)
        1
        ;;
    2)
        2
        ;;
esac
