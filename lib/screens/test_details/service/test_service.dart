
import 'package:dartz/dartz.dart';
import 'package:robquiz/model/network/most_popluar_model.dart';
import 'package:robquiz/model/network/test_details_chooses_time.dart';
import 'package:robquiz/model/network/test_details_input_model.dart';
import 'package:robquiz/shared/network/remote/base_url.dart';
import 'package:robquiz/shared/network/remote/dio_helper.dart';

class TestsService {
  Future<Either<String, TestChoosesTimeModel>> getTestDetails({required String slug,}) async {
    try {
      final response = await DioHelper.getData(
        url: '${Config.baseURL}/survey/$slug',
        // query: {
        //   "device_token":"${CacheHelper.getData(key: 'device_token')}"
        // }
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final TestChoosesTimeModel addressModel =
        TestChoosesTimeModel.fromJson(responseData);

        return Right(addressModel);
      } else {
        print('Request failed with status code: ${response.statusCode}');
        return Left('Request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      return Left('Error: $error');
    }
  }



  Future<Either<String, MostPopularModel>> getTestsLike({ int? targetId , int? categoryId}) async {
    try {
      final response = await DioHelper.getData(
          url: '${Config.baseURL}/quizzes',
          query: {
            if(targetId!=null&&targetId!=0)"target_id":targetId,
            if(categoryId!=null&&categoryId!=0)"category_id":categoryId,
          }
      );

      if (response.statusCode == 200||response.statusCode == 201||response.statusCode == 202) {
        final Map<String, dynamic> responseData = response.data;
        final MostPopularModel addressModel =
        MostPopularModel.fromJson(responseData);

        return Right(addressModel);
      } else {
        print('Request failed with status code: ${response.statusCode}');
        return Left('Request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      return Left('Error: $error');
    }
  }


  Future<Either<String, TestDetailsSuddenDeathModel>> getTestDetailsSuddenDeath({required String slug,}) async {
    try {
      final response = await DioHelper.getData(
        url: '${Config.baseURL}/survey/$slug',
        // query: {
        //   "device_token":"${CacheHelper.getData(key: 'device_token')}"
        // }
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final TestDetailsSuddenDeathModel addressModel =
        TestDetailsSuddenDeathModel.fromJson(responseData);


        return Right(addressModel);
      } else {
        print('Request failed with status code: ${response.statusCode}');
        return Left('Request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      return Left('Error: $error');
    }
  }


}