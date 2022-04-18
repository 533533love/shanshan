<?php


namespace app\api\controller;

use think\File;
use think\captcha\Captcha;
use think\Controller;
use think\response\Json;

class Goods extends Controller
{
//    添加商品
    //修改商品
//    public function xiugai(){
//        $img = $this->request->file('goodsimg');
//        $goods=model('Goods');
//        $params= $this->request->param();
//            if($img){
//                $info = $img->validate(['ext' => 'jpg,jpeg,png,gif,jfif', 'size' => 2048000])->move('../public/uploads/goods');
//                if ($info) {
//                    //获取上传文件的详情信息
//                    $info->getInfo();
//                    //获取上传文件的名
//                    $imgurl = '/uploads' . '/goods/' . $info->getSaveName();
//                    $params['goodsimg'] = $imgurl;
//                } else {
//                    $result['code'] = 404;
//                    $result['error'] = '上传失败';
//                }
//            }else{
//                unset($params['goodsimg']);
//            }
//            $info1=$goods::update($params);
//            if ($info1) {
//                $result['code'] = 200;
//                $result['msg'] = '修改成功';
//            }
//            return json($result);
//    }

//    public function add(){
//        $img = $this->request->file('goodsimg');
//        $goods=model('Goods');
//        $params= $this->request->param();
//            if ($img){
//                $info = $img->validate(['ext'=>'jpg,jpeg,png,gif,jfif','size'=>2048000])->move('../public/uploads/goods');
//                if ($info){
//                    //获取上传文件的详情信息
//                    $info->getInfo();
//                    //获取上传文件的名
//                    $imgurl = '/uploads'.'/goods/'.$info->getSaveName();
//                    $params['goodsimg']=$imgurl;
//                    $info1 = $goods->save($params);
//                    if ($info1){
//                        $result['code'] = 200;
//                        $result['msg'] = '上传成功';
//                    }
//                }else{
//                    $result['code'] = 404;
//                    $result['error'] = '上传失败';
//                }
//            }else{
//                {
//                    $result['code'] = 404;
//                    $result['error'] = '请上传商品图片';
//                }
//            }
//
//
//       return json($result);
//    }

//测试
//    public function add11(){
//        $img = $this->request->file('goodsimg');
//        $goods=model('Goods');
//        $params= $this->request->param();
//        if ($img){
//            $info = $img->validate(['ext'=>'jpg,jpeg,png,gif,jfif','size'=>2048000])->move('../public/uploads/goods');
//            if ($info){
//                //获取上传文件的详情信息
//                $info->getInfo();
//                //获取上传文件的名
//                $imgurl = '/uploads'.'/goods/'.$info->getSaveName();
//                $params['goodsimg']=$imgurl;
//                $info1 = $goods->save($params);
//                if ($info1){
//                    $result['code'] = 200;
//                    $result['msg'] = '上传成功';
//                }
//            }else{
//                $result['code'] = 404;
//                $result['error'] = '上传失败';
//            }
//        }else{
//                $result['code'] = 404;
//                $result['error'] = '请上传商品图片';
//        }
//        return json($result);
//    }


//添加或修改商品
    public function add(){
        $img = $this->request->file('goodsimg');
        $goods=model('Goods');
        $params= $this->request->param();
        if (!empty($params['id'])){
            if($img){
                $info = $img->validate(['ext' => 'jpg,jpeg,png,gif,jfif', 'size' => 2048000])->move('../public/uploads/goods');
                if ($info) {
                    //获取上传文件的详情信息
                    $info->getInfo();
                    //获取上传文件的名
                    $imgurl = '/uploads' . '/goods/' . $info->getSaveName();
                    $params['goodsimg'] = $imgurl;
                } else {
                    $result['code'] = 401;
                    $result['error'] = '上传失败';
                }
            }else{
                unset($params['goodsimg']);
            }
            $info1=$goods::update($params);
            if ($info1) {
                $result['code'] = 200;
                $result['msg'] = '修改成功';
            }
        }else{
            if ($img){
                $info = $img->validate(['ext'=>'jpg,jpeg,png,gif,jfif','size'=>2048000])->move('../public/uploads/goods');
                if ($info){
                    //获取上传文件的详情信息
                    $info->getInfo();
                    //获取上传文件的名
                    $imgurl = '/uploads'.'/goods/'.$info->getSaveName();
                    $params['goodsimg']=$imgurl;
                    $info1 = $goods->save($params);
                    if ($info1){
                        $result['code'] = 200;
                        $result['msg'] = '上传成功';
                    }
                }else{
                    $result['code'] = 402;
                    $result['error'] = '图片上传失败';
                }
            }else{
                $result['code'] = 403;
                $result['error'] = '请上传商品图片';
            }
        }
        return json($result);
    }
    //商品管理
    public function edit()
    {
        $paras = $this->request->param();
        $goods = model('Goods');
        $like=model('Like');
        if (!empty($paras['get'])) {
            $info2 = $goods->select();
                if (!empty($paras['user'])){
                    $info = $like->where(['username'=>$paras['user'],'like'=>1])->select();
                    foreach ($info2 as $key => $value){
                        foreach ($info as $k=>$v){
                            if ($value['id']==$v['goodsid']){
                                $info2[$key]['like'] = $v['like'];
                            }
                        }
                    }
                    return json($info2);
                }else{
                    return json($info2);
                }
        }elseif (!empty($paras['user'])){
            return json($goods::where('goodsman',$paras['user'])->select());
        }
        else {
            $id = $paras['id'];
            $goods::destroy($id);
            $result['code'] = 200;
            return json($result);
        }
    }
    //添加收藏
    public function collect(){
        $like=model('Like');
        $goods=model('Goods');
        $params = $this->request->param();
        if (!empty($params['user'])){
            if (!empty($params['id'])){
                    $like->add($params['id'],$params['user'],$params['flag']);
            }
        }elseif ($params['goodsid']){
            $goods->add($params['num'],$params['goodsid']);
        }
    }

}