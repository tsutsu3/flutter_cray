@echo off
setlocal ENABLEEXTENSIONS
set ABORTED=0

:: スクリプトのあるディレクトリに移動
cd /d "%~dp0"

:: プロジェクトのルートディレクトリを取得
set PROJECT_ROOT=%CD%

:: Android NDK のパスを設定（バックスラッシュをスラッシュに修正）
set ANDROID_NDK=C:/Users/ttm2t/AppData/Local/Android/Sdk/ndk/26.1.10909125

:: 環境変数に Android NDK のツールチェーンを追加
set PATH=%ANDROID_NDK%/toolchains/llvm/prebuilt/windows-x86_64/bin;%PATH%

:: CMake のパスを設定（必要に応じて変更）
set CMAKE_PATH=C:/Users/ttm2t/AppData/Local/Android/Sdk/cmake/3.31.1/bin
set PATH=%CMAKE_PATH%;%PATH%

:: 複数のアーキテクチャを設定
set ABI_LIST=arm64-v8a armeabi-v7a x86_64

:: ビルドディレクトリの作成
if not exist "%PROJECT_ROOT%\build\android" mkdir "%PROJECT_ROOT%\build\android"

:: CTRL+C で安全に終了するためのトラップ
for %%A in (%ABI_LIST%) do (
    if %ABORTED% EQU 1 goto cleanup
    echo Building for Android ABI: %%A

    :: 各アーキテクチャごとのフォルダ作成
    if not exist "%PROJECT_ROOT%\build\android\%%A" mkdir "%PROJECT_ROOT%\build\android\%%A"
    cd "%PROJECT_ROOT%\build\android\%%A"

    cmake "%PROJECT_ROOT%" ^
      -DCMAKE_SYSTEM_NAME=Android ^
      -DCMAKE_SYSTEM_VERSION=31 ^
      -DCMAKE_ANDROID_NDK=%ANDROID_NDK% ^
      -DCMAKE_ANDROID_ARCH_ABI=%%A ^
      -DCMAKE_ANDROID_STL=c++_static

    cmake --build . --config Release

    cd /d "%PROJECT_ROOT%"
)

:: ビルド終了
echo Build completed for all architectures!
endlocal
pause
