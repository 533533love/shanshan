<?php


namespace app\api\model;
use think\Model;

class Like extends model
{
    public function add($id,$user,$num){
        $info = $this->where(['goodsid'=>$id,'username'=>$user])->find();
        if ($info){
            $this::update(['id'=>$info['id'],'like'=>$num]);
        }else{
            $this->save(['goodsid'=>$id,'username'=>$user,'like'=>$num]);
        }
    }
}