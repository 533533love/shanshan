<?php
namespace app\index\controller;

use think\Controller;

class Index extends Controller
{
    public function index()
    {
        $p='我';
        return $p;
    }

    public function hello()
    {
        $arr=[
            0=>'ddd'
        ];
      array_splice($arr,0,1,'sss');
        return json($arr);
//        $imgurl=[];
//        $files =request()->file();
//        foreach($files as $key=>$file){
//            // 移动到框架应用根目录/uploads/ 目录下
//                $info = $file->validate(['ext' => 'jpg,jpeg,png,gif,jfif', 'size' => 2048000])->move('../public/comments');
//                if ($info) {
//                    //获取上传文件的详情信息
//                    $info->getInfo();
//                    //获取上传文件的名
//                    $imgurl[$key] = '/comments/'  . $info->getSaveName();
//                } else {
//                    $result['code'] = 401;
//                    $result['error'] = '上传失败';
//                }
//        }
//        return json($imgurl);
    }
}
