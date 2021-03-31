import 'dart:async';
import 'package:spotmefitness_ui/env_config.dart';
import 'package:spotmefitness_ui/services/utils.dart';
import 'package:uploadcare_client/uploadcare_client.dart';

class ProcessedVideoResult {
  final String videoUri;
  // // Full cdn url of the thumbnail derived from thumbnail group id.
  // https://ucarecdn.com/30a340f1-ed48-46dc-a733-a1c9bc9a5c5d~1/nth/0/
  final String videoThumbUri;
  ProcessedVideoResult(this.videoUri, this.videoThumbUri);
}

class UploadcareService {
  final UploadcareClient _client = UploadcareClient.withRegularAuth(
    publicKey: EnvironmentConfig.uploadCarePublicKey,
    privateKey: EnvironmentConfig.uploadCarePrivateKey,
    apiVersion: 'v0.6',
  );

  final _uploadApi = ApiUpload(
      options: ClientOptions(
          useSignedUploads: true,
          authorizationScheme: AuthSchemeRegular(
            publicKey: EnvironmentConfig.uploadCarePublicKey,
            privateKey: EnvironmentConfig.uploadCarePrivateKey,
            apiVersion: 'v0.6',
          )));

  static Future<String> getFileUrl(String fileId) async {
    CdnFile cdnFile = CdnFile(fileId);
    return cdnFile.url;
  }

  Future<FileInfoEntity> getFileInfo(String fileId) async {
    FileInfoEntity _fileInfoEntity = await _client.files.file(fileId);
    return _fileInfoEntity;
  }

  // Just uses the simple, unsigned auth scheme.
  // Implemented because the uploadcare client package always returns a FileInfoEntity when getting info.
  // FileInfoEntity has no fields for video specific data.
  // Future<VideoInfoEntity> getVideoInfoRaw(String fileId) async {
  //   dynamic res = await http.get(
  //     'https://api.uploadcare.com/files/$fileId/',
  //     // Send authorization headers to the backend.
  //     headers: {
  //       HttpHeaders.acceptHeader: 'application/vnd.uploadcare-v0.6+json',
  //       HttpHeaders.authorizationHeader:
  //           "Uploadcare.Simple ${EnvironmentConfig.uploadCarePublicKey}:${EnvironmentConfig.uploadCarePrivateKey}",
  //     },
  //   );
  //   final responseJson = await json.decode(res.body);
  //   VideoInfoEntity _videoInfo = VideoInfoEntity.fromJson(responseJson);
  //   return _videoInfo;
  // }

  Future<void> uploadImage(
      {required SharedFile file,
      void Function(ProgressEntity progress)? onProgress,
      required void Function(String uploadedUri) onComplete,
      CancelToken? cancelToken,
      void Function()? onCancel,
      required void Function(Exception) onFail}) async {
    try {
      String _fileId = await _uploadApi.base(file,
          onProgress: onProgress, cancelToken: cancelToken);
      // Check that the file has uploaded correctly and is ready for processing.
      await Utils.waitWhile(() => checkFileIsReady(_fileId),
          pollInterval: Duration(milliseconds: 500), maxAttempts: 20);
      onComplete(_fileId);
    } on CancelUploadException catch (e) {
      print('User cancelled upload');
      print(e.toString());
      if (onCancel != null) {
        onCancel();
      }
    } catch (e) {
      print(e.toString());
      onFail(Exception(e));
    }
  }

  Future<void> uploadVideo(
      {required SharedFile file,
      void Function(ProgressEntity)? onProgress,

      /// onUploaded runs once the original file is uploaded and before thumb and processed video is generated
      void Function()? onUploaded,
      required void Function(String videoUri, String videoThumburi) onComplete,
      CancelToken? cancelToken,
      required void Function(Exception) onFail}) async {
    try {
      // storeMode is false so that the original unprocessed video is deleted after 24 hours.
      String _originalFileId = await _uploadApi.auto(file,
          runInIsolate: true,
          onProgress: onProgress,
          cancelToken: cancelToken,
          storeMode: false);

      // Check that the original file has uploaded correctly and is ready for processing.
      await Utils.waitWhile(() => checkFileIsReady(_originalFileId),
          pollInterval: Duration(milliseconds: 500), maxAttempts: 40);

      if (onUploaded != null) onUploaded();

      // Create a thumbnail - hack so that uploadcare fills video info correctly (Aspect ratio etc)
      // Also means you can use the thumbnail...and you get a properly encoded video.
      ProcessedVideoResult _processedUris =
          await encodeVideoAndGenerateThumb(_originalFileId);

      // Again, check when the video is ready for use before continuing.
      await Utils.waitWhile(() => checkFileIsReady(_processedUris.videoUri),
          pollInterval: Duration(milliseconds: 1000), maxAttempts: 60);

      onComplete(_processedUris.videoUri, _processedUris.videoThumbUri);
    } on CancelUploadException catch (e) {
      print('User cancelled upload');
      print(e);
    } catch (e) {
      print(e);
      onFail(Exception(e));
    }
  }

  // Check file is ready for further processing aftre being uploading.
  Future<bool> checkFileIsReady(String cdnFileId) async {
    return (await _client.files.file(cdnFileId)).isReady;
  }

  Future<ProcessedVideoResult> encodeVideoAndGenerateThumb(String uri) async {
    VideoEncodingConvertEntity _convertedFile =
        await _client.videoEncoding.process({
      uri: [VideoThumbsGenerateTransformation(1)],
    });

    if (_convertedFile.problems.length > 0) {
      throw Exception(
          'There was a problem uploading your video, ${_convertedFile.problems.toString()}');
    } else {
      GroupInfoEntity _thumbsGroup = await _client.groups
          .group(_convertedFile.results[0].thumbnailsGroupId);

      return ProcessedVideoResult(
          _convertedFile.results[0].processedFileId, _thumbsGroup.files[0].id);
    }
  }

  Future<void> deleteFiles(
      {required List<String> fileIds,
      Function()? onComplete,
      Function(dynamic)? onFail}) async {
    try {
      await _client.files.remove(fileIds);
      if (onComplete != null) onComplete();
    } catch (e) {
      print(e.toString());
      if (onFail != null) onFail(e);
    }
  }
}
