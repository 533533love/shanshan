<?php


namespace app\api\model;
use think\Model;

class Comments extends model
{
    //添加评论
    public function order($params,$files)
    {
        $imgurl=[];
        if(!empty($files)){
            foreach($files as $key=>$file){
                // 移动到框架应用根目录/uploads/ 目录下
                $info = $file->validate(['ext' => 'jpg,jpeg,png,gif,jfif', 'size' => 2048000])->move('../public/comments');
                if ($info) {
                    //获取上传文件的详情信息
                    $info->getInfo();
                    //获取上传文件的名
                    $imgurl[$key] = '/comments/'  . $info->getSaveName();
                } else {
                    $result['code'] = 401;
                    $result['error'] = '上传失败';
                }
            }
            $imgurl=implode(',',$imgurl);
        }
        $arr = [
            'imgnums'=>$params['imgnums'],
            'imgs'=>$imgurl,
            'degree'=>$params['degree'],
            'username' => $params['user'],
            'orderid' => $params['orderid'],
            'goodsid' => $params['goodsid'],
            'time' => $params['time'],
            'comment' => $params['comment']
        ];
        $this->save($arr);
    }
    //
}