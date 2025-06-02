import 'package:dartz/dartz.dart';
import 'package:robquiz/model/network/category_model.dart';
import 'package:robquiz/model/network/most_popluar_model.dart';
import 'package:robquiz/shared/network/remote/base_url.dart';
import 'package:robquiz/shared/network/remote/dio_helper.dart';

class HomeService {
  Future<Either<String, MostPopularModel>> getMostPopular() async {
    try {
      final response = await DioHelper.getData(
        url: '${Config.baseURL}/quizzes/popular',
        // query: {
        //   "device_token":"${CacheHelper.getData(key: 'device_token')}"
        // }
      );

      if (response.statusCode == 200) {
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

  Future<Either<String, MostPopularModel>> getFeatured() async {
    try {
      final response = await DioHelper.getData(
        url: '${Config.baseURL}/quizzes/featured',
        // query: {
        //   "device_token":"${CacheHelper.getData(key: 'device_token')}"
        // }
      );

      if (response.statusCode == 200) {
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

  Future<Either<String, MostPopularModel>> getNewest() async {
    try {
      final response = await DioHelper.getData(
        url: '${Config.baseURL}/quizzes/newest',
        // query: {
        //   "device_token":"${CacheHelper.getData(key: 'device_token')}"
        // }
      );

      if (response.statusCode == 200) {
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

  Future<Either<String, MostPopularModel>> getTests({String? q , int? categoryId,String? page}) async {
    try {
      final response = await DioHelper.getData(
        url:'${Config.baseURL}/quizzes',
        query: {
          if(page!=null&&page!="")"page":page,
          if(q!=null&&q!="")"q":q,
          if(categoryId!=null&&categoryId!=0)"category_id":categoryId,
        }
      );

      if (response.statusCode == 200) {
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


  Future<Either<String, CategoryModel>> getCategory() async {
    try {
      final response = await DioHelper.getData(
        url: '${Config.baseURL}/categories',
        // query: {
        //   "device_token":"${CacheHelper.getData(key: 'device_token')}"
        // }
      );

      if (response.statusCode == 200) {
        print(response.data);
        final Map<String, dynamic> responseData = response.data;
        final CategoryModel addressModel =
        CategoryModel.fromJson(responseData);

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