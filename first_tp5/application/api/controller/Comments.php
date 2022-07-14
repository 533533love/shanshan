<?php


namespace app\api\controller;

use think\Controller;
use think\db\Where;

class Comments extends Controller{
    //为info数据添加用户图片，转化imgs数据为数组
    function loop($info,$infm,$user,$hao,$zhong,$cha){
        foreach ($info as $key=>$value){
            $userinfo = $user::where('username',$value['username'])->find();
            $value['userimg']=$userinfo['imgurl'];
            if($value['imgnums']>1){
                $value['imgs'] = explode(',',$value['imgs']);
            }
        }
        $arr = [
            'hao'=>$hao,
            'zhong'=>$zhong,
            'cha'=>$cha,
            'num'=>$infm,
            'info'=>$info
        ];
        return $arr;
    }
    //获取用户信息和评价信息
    public function getcomment(){
        $params = $this->request->param();
        $comments = model('Comments');
        $user=model('People');
        $infm=$comments::where('goodsid',$params['goodsid'])->count();
//        Db::table('think_user')->where([
//            'name'	=>	'thinkphp',
//            'status'=>	[1, 2]
//        ])->select();
        $hao= $comments::where(['goodsid'=>$params['goodsid'],'degree'=>[5]])->count();
        $zhong = $comments::where(['goodsid'=>$params['goodsid'],'degree'=>[3,4]])->count();
        $cha = $comments::where(['goodsid'=>$params['goodsid'],'degree'=>[1,2]])->count();
        if(!empty($params['all'])){
            $info = $comments::where('goodsid',$params['goodsid'])->order('id', 'desc')->select();
            $arr=$this->loop($info,$infm,$user,$hao,$zhong,$cha);
            return json($arr);
        }else{
            $info = $comments::where('goodsid',$params['goodsid'])->order('id', 'desc')->limit(5)->select();
            $arr=$this->loop($info,$infm,$user,$hao,$zhong,$cha);
            return json($arr);
        }
    }
    //获取商品信息和评价信息
    public function getgp(){
        $comment = model('Comments');
        $goods=model('Goods');
        $param=$this->request->param('orderid');
        $info = $comment::where('orderid',$param)->select();
        if(count($info)>1){
            $info=$info->toArray();//转化成数组才可更改内部数据
            foreach ($info as $k=>$v){
                $info1=$goods::where('id',$info[$k]['goodsid'])->find();
                $info[$k]['goodsimg']=$info1['goodsimg'];
                $info[$k]['goodsname']=$info1['goodsname'];
                if($info[$k]['imgnums']){
                    $info[$k]['imgs']= explode(',',$info[$k]['imgs']);
                }
            }
        }else{
            $info1=$goods::where('id',$info[0]['goodsid'])->find();
            $info[0]['goodsimg']=$info1['goodsimg'];
            $info[0]['goodsname']=$info1['goodsname'];
            if($info[0]['imgnums']){
                $info[0]['imgs']= explode(',',$info[0]['imgs']);
            }
        }

        return json($info);
    }
    //订单详情页面添加评价
    public function chaping(){
        $param=$this->request->param();
        $comments=model('Comments');
        $info=$comments::where(['goodsid'=>$param['goodsid'],'orderid'=>$param['id']])->find();
        $goods = model('Goods');
        $info1=$goods::where('id',$param['goodsid'])->find();
        $info['goodsimg']=$info1['goodsimg'];
        $info['goodsname']=$info1['goodsname'];
        if ($info['imgnums']){
            $info['imgs']=explode(',',$info['imgs']);
        }
        return json($info);
    }
}