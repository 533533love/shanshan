<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
use think\facade\Route;
Route::get('think', function () {
    return 'hello,ThinkPHP5!';
});

Route::get('hello', 'index/index/hello')->allowCrossDomain();
Route::get('user','api/User/read')->allowCrossDomain();
Route::post('huo','api/User/huo')->allowCrossDomain();
Route::get('biao','api/User/biao')->allowCrossDomain();
Route::get('img','api/Img/verify')->allowCrossDomain();
Route::post('zhuce','api/User/zhuce')->allowCrossDomain();
Route::post('denglu','api/User/denglu')->allowCrossDomain();
Route::post('state','api/User/state')->allowCrossDomain();
Route::post('xianshi','api/User/xianshi')->allowCrossDomain();
Route::post('usdenglu','api/User/usdenglu')->allowCrossDomain();
Route::post('chatu','api/Img/chatu')->allowCrossDomain();
Route::post('add','api/Goods/add')->header('Access-Control-Allow-Origin','*')
    ->header('Access-Control-Allow-Credentials', 'true')->allowCrossDomain();
Route::post('xiugai','api/Goods/xiugai')->header('Access-Control-Allow-Origin','*')
    ->header('Access-Control-Allow-Credentials', 'true')->allowCrossDomain();
Route::post('edit','api/Goods/edit')->allowCrossDomain();
Route::post('buy','api/Order/buy')->allowCrossDomain();
Route::post('jizhu','api/User/jizhu')->allowCrossDomain();
Route::post('shop','api/Order/shop')->allowCrossDomain();
Route::post('tijiao','api/Order/tijiao')->allowCrossDomain();
Route::post('order','api/Order/order')->allowCrossDomain();
Route::post('getorder','api/Order/getorder')->allowCrossDomain();
Route::post('quxiao','api/Order/quxiao')->allowCrossDomain();
Route::post('collect','api/Goods/collect')->allowCrossDomain();
Route::post('getcom','api/Comments/getcomment')->allowCrossDomain();
Route::post('tianjia','api/Comments/tianjia')->allowCrossDomain();
Route::post('getgp','api/Comments/getgp')->allowCrossDomain();
Route::post('shou','api/Order/shou')->allowCrossDomain();
Route::post('chaping','api/Comments/chaping')->allowCrossDomain();